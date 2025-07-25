import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleController extends GetxController {
  String? classId;
  String? teacherId;

  ScheduleController({this.classId, this.teacherId});

  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime> focusedDay = DateTime.now().obs;
  Rx<DateTime> firstDay = DateTime.now().obs;
  Rx<DateTime> lastDay = DateTime.now().obs;

  Rx<CalendarFormat> calendarFormat = CalendarFormat.month.obs;

  late Future<void> initScheduleFuture;

  @override
  void onInit() {
    super.onInit();

    firstDay.value = DateTime.utc(2019, 1, 29);
    lastDay.value = DateTime.now().add(const Duration(days: 365));

    initScheduleFuture = initData();
  }

  Future<void> initData() async {
    await Future.delayed(const Duration(seconds: 3));
  }

  Future<void> onRefresh() async {
    await initData();

    return await Future.delayed(const Duration(milliseconds: 1000));
  }

  void onDaySelected({
    required DateTime selectedDay,
    required DateTime focusedDay,
  }) {
    this.selectedDay.value = selectedDay;
    this.focusedDay.value = focusedDay;
    update(['update-calendar', 'update-events']);
  }

  void onFormatChanged(CalendarFormat format) {
    calendarFormat.value = format;
    update(['update-calendar']);
  }

  void onPageChanged(DateTime focusedDay) {
    this.focusedDay.value = focusedDay;
    update(['update-calendar']);
  }
}
