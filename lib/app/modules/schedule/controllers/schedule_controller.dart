import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/schedule.dart';
import 'package:wingapp/utils/util.dart';

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
  RxMap<String, List<Schedule>> dateSchedules = RxMap<String, List<Schedule>>();

  // 日期对应的课程数量
  // key 是月份 如 2025-07
  // value 是课程数量
  RxMap<String, List<int>> dateScheduleCounts = RxMap<String, List<int>>();

  late Future<void> initScheduleFuture;

  @override
  void onInit() {
    super.onInit();

    firstDay.value = DateTime.utc(2019, 1, 29);
    lastDay.value = DateTime.now().add(const Duration(days: 365));

    initScheduleFuture = initData(isInit: true);
  }

  List<Map<String, dynamic>> groupByStartFold(
      List<Map<String, dynamic>> items) {
    final map = items.fold<Map<String, List<Map<String, dynamic>>>>(
      {},
      (acc, item) {
        final key = item['start'] as String;
        acc.putIfAbsent(key, () => []).add(item);
        return acc;
      },
    );
    final result = map.entries
        .map((e) => {
              'start': e.key,
              'list': e.value,
            })
        .toList();
    result
        .sort((a, b) => (a['start'] as String).compareTo(b['start'] as String));
    return result;
  }

  Future<void> getSchedules() async {
    String shortDate = dateFormat(
        timestamp: selectedDay.value.millisecondsSinceEpoch.toString(),
        format: 'yyyy-MM-dd');

    if (dateSchedules.containsKey(shortDate)) {
      return;
    }

    NormalResponse response = await scheduleService.getSchedules(
      classId: classId,
      teacherId: teacherId,
      date: dateFormat(
          timestamp: selectedDay.value.millisecondsSinceEpoch.toString(),
          format: 'yyyy-MM-dd hh:mm:ss'),
    );

    print(
        '>>>>>>>>>>> response: ${groupByStartFold(response.data!['list']).map((e) => Map<String, dynamic>.from(e))}');

    if (response.code == 200 && response.data != null) {
      if (response.data!['list'] != null && response.data!['list'].isNotEmpty) {
        dateSchedules[shortDate] = response.data!['list']
            .map<Schedule>((e) => Schedule.fromJson(e))
            .toList();
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

      update(['update-calendar']);
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

    if (dateScheduleCounts.containsKey(shortDate) &&
        dateScheduleCounts[shortDate]!.isEmpty) {
      dateScheduleCounts.remove(shortDate);
      update(['update-calendar']);
    }
  }

  Future<void> onRefresh() async {
    await resetFocusedDayData();
    await initData(isInit: false);
  }

  Future<void> onDaySelected({
    required DateTime selectedDay,
    required DateTime focusedDay,
  }) async {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    await getSchedules();
    update(['update-calendar', 'update-schedules']);
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
    update(['update-calendar']);
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
}
