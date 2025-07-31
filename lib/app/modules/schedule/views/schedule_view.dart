import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_indicator_builder/custom_indicator_builder.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/database/database.dart';

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
    } else {
      if (!Get.isRegistered<ScheduleController>()) {
        Get.put<ScheduleController>(
          ScheduleController(),
        );
      }
    }
  }

  @override
  ScheduleController get controller =>
      ((classId != null && classId!.isNotEmpty) ||
              (teacherId != null && teacherId!.isNotEmpty))
          ? Get.find<ScheduleController>(
              tag: 'schedule-${classId ?? ''}-${teacherId ?? ''}')
          : Get.find<ScheduleController>();

  Widget _buildScheduleItem({
    required Schedule item,
    required bool isCompleted,
  }) {
    return Card(
      elevation: 0,
      color: isCompleted ? Colors.white24 : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Column(
          children: [
            Container(
              // height: 20,
              padding: EdgeInsets.zero,
              child: Row(
                spacing: 6,
                children: [
                  Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.className,
                      style: Get.theme.textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Container(
                    height: 20,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F8F8),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      item.teacherName,
                      style: Get.theme.textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 48,
              alignment: Alignment.centerLeft,
              child: Text(
                item.title ?? '',
                style: Get.theme.textTheme.titleMedium?.copyWith(
                  color: Colors.black87,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                item.content ?? '',
                // item.content?.replaceAll('[时间]',
                //         '${DateFormat('HH:mm').format(DateTime.parse(item.start ?? ''))} - ${DateFormat('HH:mm').format(DateTime.parse(item.end ?? ''))}') ??
                //     '',
                style: Get.theme.textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                ),
              ),
            ),
            Container(
              height: 24,
              margin: EdgeInsets.only(
                top: 12,
              ),
              alignment: Alignment.centerLeft,
              child: Row(
                spacing: 6,
                children: [
                  Icon(
                    Icons.access_time,
                    size: 14,
                    color: Colors.black54,
                  ),
                  Text(
                    DateFormat('HH:mm').format(
                      DateTime.parse(item.start ?? ''),
                    ),
                    style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  Text(
                    '-',
                    style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black38,
                    ),
                  ),
                  Text(
                    DateFormat('HH:mm').format(
                      DateTime.parse(item.end ?? ''),
                    ),
                    style: Get.theme.textTheme.bodySmall?.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchedules(ScheduleItem item) {
    EScheduleStatus status = controller.getScheduleStatus(
      start: item.list.first.start!,
      end: item.list.first.end!,
    );
    Color color = switch (status) {
      EScheduleStatus.pending => Colors.white,
      EScheduleStatus.active => Color(0xFF31D98D),
      EScheduleStatus.completed => Colors.white30,
    };
    Color textColor = switch (status) {
      EScheduleStatus.pending => Colors.black54,
      EScheduleStatus.active => Colors.white,
      EScheduleStatus.completed => Colors.black12,
    };
    return SliverStickyHeader(
      overlapsContent: true,
      header: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 16,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: UnconstrainedBox(
            child: Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.centerLeft,
              child: Text(
                item.start.split(" ").last,
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ),
        ),
      ),
      sliver: SliverPadding(
        padding: const EdgeInsets.only(
          left: 86,
          top: 12,
          right: 12,
        ),
        sliver: SliverList.builder(
          itemBuilder: (context, index) => _buildScheduleItem(
            item: item.list[index],
            isCompleted: status == EScheduleStatus.completed,
          ),
          itemCount: item.list.length,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
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
            onPressed: () {
              controller.gotoAddSchedule();
            },
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
            return GetBuilder(
              id: 'update-schedules',
              init: controller,
              builder: (_) {
                return CustomScrollView(
                  controller: controller.scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
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
                                    color: Colors.black54,
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
                            cellMargin: EdgeInsets.all(10),
                            todayDecoration: isSameDay(
                                    controller.selectedDay.value,
                                    DateTime.now())
                                ? BoxDecoration(
                                    color: Get.theme.primaryColor,
                                    shape: BoxShape.circle,
                                  )
                                : BoxDecoration(
                                    color: Get.theme.primaryColor.withValues(
                                      alpha: 0.3,
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
                          // eventLoader: (day) {
                          //   String shortDate = dateFormat(
                          //     timestamp: day.millisecondsSinceEpoch.toString(),
                          //     format: 'yyyy-MM-dd hh:mm:ss',
                          //   );
                          //   int index = controller.dateSchedules.indexWhere(
                          //     (e) => e.start == shortDate,
                          //   );
                          //   if (index != -1) {
                          //     return controller.dateSchedules[index].list;
                          //   }
                          //   return [];
                          // },
                        ),
                      ),
                    ),
                    for (ScheduleItem item in controller.currentScheduleItems)
                      _buildSchedules(item),
                    if (controller.currentScheduleItems.isEmpty)
                      SliverToBoxAdapter(
                        child: SizedBox(
                          width: Get.width,
                          height: 100,
                          child: Center(
                            child: Text(
                              'no_data'.tr,
                              style: Get.theme.textTheme.bodySmall,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
