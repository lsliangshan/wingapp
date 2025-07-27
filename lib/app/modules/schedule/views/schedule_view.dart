import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_indicator_builder/custom_indicator_builder.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/utils/util.dart';

import '../controllers/schedule_controller.dart';

// ignore: must_be_immutable
class ScheduleView extends GetView {
  String? classId;
  String? teacherId;
  ScheduleView({super.key, this.classId, this.teacherId}) {
    if ((classId != null && classId!.isNotEmpty) ||
        (teacherId != null && teacherId!.isNotEmpty)) {
      Get.put<ScheduleController>(
        ScheduleController(
          classId: classId ?? '',
          teacherId: teacherId ?? '',
        ),
        tag: 'student-${classId ?? ''}-${teacherId ?? ''}',
      );
    }
  }

  @override
  ScheduleController get controller =>
      ((classId != null && classId!.isNotEmpty) ||
              (teacherId != null && teacherId!.isNotEmpty))
          ? Get.find<ScheduleController>(
              tag: 'schedule-${classId ?? ''}-${teacherId ?? ''}')
          : Get.find<ScheduleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'schedule.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        // backgroundColor: Get.theme.scaffoldBackgroundColor,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: ((classId != null && classId!.isNotEmpty) ||
                (teacherId != null && teacherId!.isNotEmpty))
            ? const CustomBackwardView()
            : const SizedBox.shrink(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/svgs/icon_plus.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: CustomMaterialIndicator(
        onRefresh: controller.onRefresh,
        backgroundColor: Colors.white,
        indicatorBuilder: customIndicatorBuilder,
        child: FutureBuilder(
          future: controller.initScheduleFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CustomLoader(),
              );
            }
            return CustomScrollView(
              controller: controller.scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                GetBuilder(
                  id: 'update-calendar',
                  init: controller,
                  builder: (_) {
                    return SliverAppBar(
                      pinned: true,
                      shadowColor: Colors.transparent,
                      surfaceTintColor: Colors.transparent,
                      foregroundColor: Colors.black,
                      expandedHeight: controller.calendarFormat.value ==
                              CalendarFormat.month
                          ? 400
                          : controller.calendarFormat.value ==
                                  CalendarFormat.twoWeeks
                              ? 196
                              : 142,
                      collapsedHeight: controller.calendarFormat.value ==
                              CalendarFormat.month
                          ? 400
                          : controller.calendarFormat.value ==
                                  CalendarFormat.twoWeeks
                              ? 196
                              : 142,
                      backgroundColor: Colors.white,
                      flexibleSpace: SafeArea(
                        child: TableCalendar(
                          firstDay: controller.firstDay.value,
                          lastDay: controller.lastDay.value,
                          focusedDay: controller.focusedDay.value,
                          locale: 'language'.tr,
                          calendarFormat: controller.calendarFormat.value,
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          availableGestures: AvailableGestures.horizontalSwipe,
                          availableCalendarFormats: {
                            CalendarFormat.month: 'calendar.month'.tr,
                            CalendarFormat.twoWeeks: 'calendar.twoWeeks'.tr,
                            CalendarFormat.week: 'calendar.week'.tr,
                          },
                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, day, events) {
                              String shortDate =
                                  '${day.year}-${day.month.toString().padLeft(2, '0')}';
                              int count = 0;
                              if (controller.dateScheduleCounts[shortDate] !=
                                      null &&
                                  controller.dateScheduleCounts[shortDate]!
                                          .length >=
                                      day.day) {
                                count = controller.dateScheduleCounts[
                                    shortDate]![day.day - 1];
                              }

                              if (count == 0) {
                                return const SizedBox.shrink();
                              }

                              return Positioned(
                                left: 20,
                                bottom: 0,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    '$count',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          calendarStyle: CalendarStyle(
                            todayDecoration: isSameDay(
                                    controller.selectedDay.value,
                                    DateTime.now())
                                ? BoxDecoration(
                                    color: Get.theme.primaryColor,
                                    shape: BoxShape.circle,
                                  )
                                : BoxDecoration(
                                    color: Get.theme.primaryColor.withValues(
                                      alpha: 0.5,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                            selectedDecoration: BoxDecoration(
                              color: Get.theme.primaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          selectedDayPredicate: (day) {
                            return isSameDay(controller.selectedDay.value, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            controller.onDaySelected(
                              selectedDay: selectedDay,
                              focusedDay: focusedDay,
                            );
                          },
                          onPageChanged: controller.onPageChanged,
                          onFormatChanged: controller.onFormatChanged,
                          // eventLoader: controller.getEventsForDaySync,
                          eventLoader: (day) {
                            return controller.dateSchedules[dateFormat(
                                  timestamp:
                                      day.millisecondsSinceEpoch.toString(),
                                  format: 'yyyy-MM-dd',
                                )] ??
                                [];
                          },
                        ),
                      ),
                    );
                  },
                ),
                GetBuilder(
                  id: 'update-schedules',
                  init: controller,
                  builder: (_) {
                    return SliverList.builder(
                      itemCount: controller
                              .dateSchedules[dateFormat(
                            timestamp: controller
                                .selectedDay.value.millisecondsSinceEpoch
                                .toString(),
                            format: 'yyyy-MM-dd',
                          )]
                              ?.length ??
                          0,
                      itemBuilder: (context, index) {
                        Schedule schedule = controller.dateSchedules[dateFormat(
                          timestamp: controller
                              .selectedDay.value.millisecondsSinceEpoch
                              .toString(),
                          format: 'yyyy-MM-dd',
                        )]![index];
                        return Container(
                          width: Get.width,
                          color: Colors.red,
                          child: Text(schedule.title!),
                        );
                      },
                    );
                  },
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: Get.width,
                    height: 1000,
                    color: Colors.white,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    width: Get.width,
                    height: 1000,
                    color: Colors.green,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
