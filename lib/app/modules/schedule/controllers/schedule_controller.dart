import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wingapp/app/modules/add_schedule/views/add_schedule_view.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/schedule.dart';
import 'package:wingapp/utils/util.dart';

class ScheduleItem {
  String start;
  List<Schedule> list;

  ScheduleItem({
    required this.start,
    required this.list,
  });

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'list': list.map((e) => e.toJson()).toList(),
    };
  }
}

enum EScheduleStatus {
  // 未开始
  pending,
  // 进行中
  active,
  // 已完成
  completed,
}

extension DateWithTimeString on DateTime {
  DateTime withTimeFromString(String timeString) {
    final t = DateTime.parse(timeString);
    return DateTime(year, month, day, t.hour, t.minute, t.second, t.millisecond,
        t.microsecond);
  }
}

class ScheduleController extends GetxController {
  String? classId;
  String? teacherId;

  ScheduleController({this.classId, this.teacherId});

  ScheduleService scheduleService = Get.find<ScheduleService>();

  ScrollController scrollController = ScrollController();

  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> firstDay = DateTime.now().obs;
  Rx<DateTime> lastDay = DateTime.now().obs;

  Rx<CalendarFormat> calendarFormat = CalendarFormat.twoWeeks.obs;

  // 日期对应的课程
  // key 是日期 如 2025-07-01
  // value 是课程列表
  RxList<ScheduleItem> dateSchedules = RxList<ScheduleItem>();

  // 日期对应的课程数量
  // key 是月份 如 2025-07
  // value 是课程数量
  RxMap<String, List<int>> dateScheduleCounts = RxMap<String, List<int>>();

  late Future<void> initScheduleFuture;

  RxList<ScheduleItem> currentScheduleItems = RxList<ScheduleItem>();

  @override
  void onInit() {
    super.onInit();

    firstDay.value = DateTime.utc(2019, 1, 29);
    lastDay.value = DateTime.now().add(const Duration(days: 365));

    initScheduleFuture = initData(isInit: true);
  }

  List<ScheduleItem> groupByStartFold({
    // date 如 2025-07-01
    required String date,
    required List<dynamic> items,
  }) {
    List<ScheduleItem> map = items.fold<List<ScheduleItem>>(
      [],
      (acc, item) {
        final index = acc.indexWhere((e) => e.start == date);
        if (index != -1) {
          acc[index].list.add(Schedule.fromJson(item));
        } else {
          acc.add(ScheduleItem(
            start: date,
            list: [Schedule.fromJson(item)],
          ));
        }
        return acc;
      },
    );
    return map;
  }

  List<ScheduleItem> groupByList({
    required List<dynamic> items,
  }) {
    List<ScheduleItem> map = items.fold<List<ScheduleItem>>(
      [],
      (acc, item) {
        final index = acc.indexWhere((e) => e.start == item.start);
        if (index != -1) {
          acc[index].list.add(item);
        } else {
          acc.add(ScheduleItem(
            start: item.start,
            list: [item],
          ));
        }
        return acc;
      },
    );
    return map;
  }

  Future<void> getSchedules() async {
    String shortDate = dateFormat(
        timestamp: selectedDay.value.millisecondsSinceEpoch.toString(),
        format: 'yyyy-MM-dd');

    if (dateSchedules.any((e) => e.start == shortDate)) {
      return;
    }

    NormalResponse response = await scheduleService.getSchedules(
      classId: classId,
      teacherId: teacherId,
      date: shortDate,
    );

    if (response.code == 200 && response.data != null) {
      if (response.data!['list'] != null && response.data!['list'].isNotEmpty) {
        dateSchedules.addAll(groupByStartFold(
          date: shortDate,
          items: response.data!['list'],
        ));
      }
      update(['update-schedules']);
    }
  }

  Future<void> getScheduleCountsMonthly({
    required DateTime date,
  }) async {
    String shortDate = dateFormat(
        timestamp: date.millisecondsSinceEpoch.toString(), format: 'yyyy-MM');

    if (dateScheduleCounts.containsKey(shortDate)) {
      return;
    }

    NormalResponse response = await scheduleService.getScheduleCountsMonthly(
      date: dateFormat(
          timestamp: date.millisecondsSinceEpoch.toString(),
          format: 'yyyy-MM-dd hh:mm:ss'),
    );

    if (response.code == 200 && response.data != null) {
      dateScheduleCounts[shortDate] = response.data['counts']
          .map<int>((e) => int.tryParse('$e') ?? 0)
          .toList();

      update(['update-schedules']);
    }
  }

  Future<void> initData({
    bool isInit = true,
  }) async {
    await getScheduleCountsMonthly(date: focusedDay.value);
    if (isInit) {
      DateTime prevMonth =
          DateTime(focusedDay.value.year, focusedDay.value.month - 1, 1);
      DateTime nextMonth =
          DateTime(focusedDay.value.year, focusedDay.value.month + 1, 1);

      await Future.wait([
        getScheduleCountsMonthly(date: prevMonth),
        getScheduleCountsMonthly(date: nextMonth),
      ]);
    }
    await getSchedules();
  }

  Future<void> resetFocusedDayData() async {
    String shortDate = dateFormat(
        timestamp: focusedDay.value.millisecondsSinceEpoch.toString(),
        format: 'yyyy-MM');
    String midiumDate = dateFormat(
        timestamp: focusedDay.value.millisecondsSinceEpoch.toString(),
        format: 'yyyy-MM-dd');

    if (dateScheduleCounts.containsKey(shortDate) &&
        dateScheduleCounts[shortDate]!.isNotEmpty) {
      dateScheduleCounts.remove(shortDate);
      update(['update-schedules']);
    }
    int index = dateSchedules.indexWhere((e) => e.start == midiumDate);

    if (index != -1) {
      dateSchedules.removeAt(index);
      update(['update-schedules']);
    }
  }

  Future<void> onRefresh() async {
    await resetFocusedDayData();
    await initData(isInit: false);
    updateCurrentSchedules();
  }

  EScheduleStatus getScheduleStatus({
    required String start,
    required String end,
  }) {
    DateTime now = DateTime.now();
    DateTime startDate = selectedDay.value.withTimeFromString(start);
    DateTime endDate = selectedDay.value.withTimeFromString(end);

    if (now.isBefore(startDate)) {
      return EScheduleStatus.pending;
    } else if (now.isAfter(startDate) && now.isBefore(endDate)) {
      return EScheduleStatus.active;
    } else {
      return EScheduleStatus.completed;
    }
  }

  void updateCurrentSchedules() {
    String shortDate = dateFormat(
        timestamp: selectedDay.value.millisecondsSinceEpoch.toString(),
        format: 'yyyy-MM-dd');

    int index = dateSchedules.indexWhere((e) => e.start == shortDate);

    if (index != -1) {
      currentScheduleItems.value = groupByList(
        items: dateSchedules[index].list,
      );
    } else {
      currentScheduleItems.value = [];
    }
    update(['update-schedules']);
  }

  Future<void> onDaySelected({
    required DateTime selectedDay,
    required DateTime focusedDay,
  }) async {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    await getSchedules();
    updateCurrentSchedules();
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
    update(['update-schedules']);
  }

  Future<void> onPageChanged(DateTime focusedDay) async {
    this.focusedDay.value = focusedDay;
    DateTime prevMonth = DateTime(focusedDay.year, focusedDay.month - 1, 1);
    DateTime nextMonth = DateTime(focusedDay.year, focusedDay.month + 1, 1);

    await Future.wait([
      getScheduleCountsMonthly(date: focusedDay),
      getScheduleCountsMonthly(date: prevMonth),
      getScheduleCountsMonthly(date: nextMonth),
    ]);
  }

  void gotoAddSchedule() {
    Get.to(() => AddScheduleView(
          // classId: "39a1e196-71ad-4698-8d5b-2f7719968839",
          formId: '456766a7-438e-4b80-9b55-3c6f1ab93321',
        ));
  }
}
