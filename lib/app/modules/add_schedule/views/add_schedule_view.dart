import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/input_formatter/number_value_limit_input_formatter.dart';
import 'package:wingapp/input_formatter/pure_number_input_formatter.dart';

import '../controllers/add_schedule_controller.dart';

class AddScheduleView extends GetView<AddScheduleController> {
  const AddScheduleView({super.key});

  Widget _buildSchedules() {
    return Column(
      spacing: 4,
      children: [
        for (ScheduleEntity schedule in controller.formData.value.schedule)
          Container(
            color: Colors.white,
            height: 32,
            padding: EdgeInsets.only(
              left: 16,
              right: 6,
            ),
            child: Row(
              spacing: 4,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  child: Checkbox.adaptive(
                    value: schedule.repeats,
                    onChanged: (value) {
                      schedule.repeats = value ?? false;
                      controller.update(['update-form-data']);
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.changeDate(schedule);
                  },
                  child: Container(
                    width: 106,
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Get.theme.dividerColor.withValues(alpha: 0.1),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                        left: 4,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/tab_schedule_selected.svg',
                            width: 14,
                            height: 14,
                            colorFilter: ColorFilter.mode(
                              Get.theme.colorScheme.onSurface
                                  .withValues(alpha: 0.3),
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            schedule.repeats
                                ? '${Get.locale!.languageCode == 'zh' ? '每' : ''}${DateFormat(Get.locale!.languageCode == 'zh' ? 'EE' : 'EEEE', Get.locale!.languageCode).format(schedule.date)}'
                                : DateFormat('yyyy-MM-dd')
                                    .format(schedule.date),
                            style: Get.theme.textTheme.bodyMedium?.copyWith(
                              color: Get.theme.hintColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      controller.changeTime(schedule);
                    },
                    child: Container(
                      height: 32,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Get.theme.dividerColor.withValues(alpha: 0.1),
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                          left: 4,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/icon_time_square.svg',
                              width: 14,
                              height: 14,
                              colorFilter: ColorFilter.mode(
                                Get.theme.colorScheme.onSurface
                                    .withValues(alpha: 0.3),
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              '${DateFormat('HH:mm').format(schedule.range[0])} - ${DateFormat('HH:mm').format(schedule.range[1])}',
                              style: Get.theme.textTheme.bodyMedium?.copyWith(
                                color: Get.theme.hintColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  child: controller.formData.value.schedule.length > 1
                      ? IconButton(
                          onPressed: () {
                            controller.removeSchedule(schedule);
                          },
                          icon: SvgPicture.asset(
                            'assets/svgs/icon_close.svg',
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              Get.theme.colorScheme.onSurface
                                  .withValues(alpha: 0.3),
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        Container(
          height: 28,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 12, left: 52),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
            ),
            onPressed: () {
              controller.addScheduleTime();
            },
            child: Text(
              'add_schedule.form_data.add_time'.tr,
              style: Get.theme.textTheme.bodySmall?.copyWith(
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReminders() {
    return Column(
      spacing: 4,
      children: [
        for (ReminderEntity reminder in controller.formData.value.reminders)
          Container(
            color: Colors.white,
            height: 32,
            padding: EdgeInsets.only(
              left: 16,
              right: 6,
            ),
            child: Row(
              spacing: 4,
              children: [
                Container(
                  width: 64,
                  height: 32,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '提前',
                    style: Get.theme.textTheme.bodyMedium?.copyWith(
                      color: Get.theme.hintColor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Get.theme.dividerColor.withValues(alpha: 0.1),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: TextFormField(
                      controller: controller.reminderControllers[reminder.id],
                      focusNode: controller.reminderFocusNodes[reminder.id],
                      onTapOutside: (value) {
                        controller.reminderFocusNodes[reminder.id]!.unfocus();
                      },
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        PureNumberInputFormatter(),
                        NumberValueLimitInputFormatter(
                          min: 1,
                          max: reminder.unit == 'hour'
                              ? 672
                              : reminder.unit == 'day'
                                  ? 28
                                  : reminder.unit == 'week'
                                      ? 4
                                      : 40320,
                        ),
                      ],
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 4,
                        ),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.changeReminderUnit(reminder);
                  },
                  child: Container(
                    width: 106,
                    height: 32,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Get.theme.dividerColor.withValues(alpha: 0.1),
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              reminder.unit.tr,
                              style: Get.theme.textTheme.bodyMedium?.copyWith(
                                color: Get.theme.hintColor,
                              ),
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/svgs/icon_arrow_down.svg',
                            width: 14,
                            height: 14,
                            colorFilter: ColorFilter.mode(
                              Get.theme.colorScheme.onSurface
                                  .withValues(alpha: 0.3),
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  child: controller.formData.value.reminders.length > 1
                      ? IconButton(
                          onPressed: () {
                            controller.removeReminder(reminder);
                          },
                          icon: SvgPicture.asset(
                            'assets/svgs/icon_close.svg',
                            width: 16,
                            height: 16,
                            colorFilter: ColorFilter.mode(
                              Get.theme.colorScheme.onSurface
                                  .withValues(alpha: 0.3),
                              BlendMode.srcIn,
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        Container(
          height: 28,
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(top: 12, left: 52),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: Get.theme.colorScheme.primary,
                ),
              ),
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
            ),
            onPressed: () {
              controller.addReminder();
            },
            child: Text(
              'add_schedule.form_data.add_reminder'.tr,
              style: Get.theme.textTheme.bodySmall?.copyWith(
                color: Get.theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add_schedule.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: const CustomBackwardView(),
      ),
      body: FutureBuilder(
        future: controller.initAddClassFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CustomLoader(),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      ListTile(
                        dense: true,
                        onTap: () {
                          controller.chooseClass();
                        },
                        leading: SizedBox(
                          width: 80,
                          height: 48,
                          child: Row(
                            children: [
                              Text(
                                'add_schedule.form_data.class'.tr,
                                style: Get.theme.textTheme.labelLarge?.copyWith(
                                  color: Get.theme.hintColor,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                '*',
                                style: Get.theme.textTheme.labelLarge?.copyWith(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        title: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GetBuilder(
                              id: 'update-form-data',
                              init: controller,
                              builder: (_) {
                                return Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.formData.value.className,
                                          style: Get.theme.textTheme.titleMedium
                                              ?.copyWith(
                                            color: controller.formData.value
                                                    .className.isNotEmpty
                                                ? Get.theme.hintColor
                                                : Get.theme.disabledColor,
                                          ),
                                        ),
                                        SvgPicture.asset(
                                          'assets/svgs/icon_arrow_right.svg',
                                          width: 20,
                                          height: 20,
                                          colorFilter: ColorFilter.mode(
                                            Get.theme.colorScheme.onSurface
                                                .withValues(alpha: 0.18),
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 16),
                        visualDensity: VisualDensity.compact,
                      ),
                      GetBuilder(
                        id: 'update-form-data',
                        init: controller,
                        builder: (_) {
                          return (controller.formData.value.classId.isNotEmpty)
                              ? Column(
                                  children: [
                                    Divider(
                                      height: 0.5,
                                      color: Get.theme.dividerColor
                                          .withValues(alpha: 0.02),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: 0,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'add_schedule.form_data.title'.tr,
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                              color: Get.theme.hintColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '*',
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextFormField(
                                      controller: controller.titleController,
                                      focusNode: controller.titleFocusNode,
                                      onTapOutside: (value) {
                                        controller.titleFocusNode.unfocus();
                                      },
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        border: InputBorder.none,
                                        hintText:
                                            'add_schedule.form_data.title.hint'
                                                .tr,
                                        hintStyle: Get
                                            .theme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: Get.theme.disabledColor,
                                        ),
                                        suffixIcon: controller
                                                .formData.value.title.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller.clearTitle();
                                                },
                                                child: const SizedBox(
                                                  width: 36,
                                                  height: 36,
                                                  child: Icon(
                                                    Icons.clear_outlined,
                                                    size: 16,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                    Divider(
                                      height: 0.5,
                                      color: Get.theme.dividerColor
                                          .withValues(alpha: 0.02),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: 0,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'add_schedule.form_data.content'.tr,
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                              color: Get.theme.hintColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '*',
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 16,
                                          ),
                                          Container(
                                            height: 24,
                                            alignment: Alignment.centerLeft,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  // side: BorderSide(
                                                  //   color: Get.theme.colorScheme.primary,
                                                  // ),
                                                ),
                                                visualDensity:
                                                    VisualDensity.compact,
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 4,
                                                ),
                                              ),
                                              onPressed: () {
                                                controller
                                                    .insertTemplateAtCursor(
                                                  template: '[时间]',
                                                );
                                              },
                                              child: Text(
                                                'add_schedule.form_data.insert_time'
                                                    .tr,
                                                style: Get
                                                    .theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: Get.theme.colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextFormField(
                                      controller: controller.contentController,
                                      focusNode: controller.contentFocusNode,
                                      onTapOutside: (value) {
                                        controller.contentFocusNode.unfocus();
                                      },
                                      maxLines: 6,
                                      minLines: 6,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 10,
                                        ),
                                        border: InputBorder.none,
                                        hintText:
                                            'add_schedule.form_data.content.hint'
                                                .tr,
                                        hintStyle: Get
                                            .theme.textTheme.titleMedium
                                            ?.copyWith(
                                          color: Get.theme.disabledColor,
                                        ),
                                        suffixIcon: controller.formData.value
                                                .content.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller.clearContent();
                                                },
                                                child: const SizedBox(
                                                  width: 36,
                                                  height: 36,
                                                  child: Icon(
                                                    Icons.clear_outlined,
                                                    size: 16,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            : null,
                                      ),
                                    ),
                                    Divider(
                                      height: 0.5,
                                      color: Get.theme.dividerColor
                                          .withValues(alpha: 0.02),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'add_schedule.form_data.time'.tr,
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                              color: Get.theme.hintColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '*',
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    _buildSchedules(),
                                    SizedBox(
                                      height: 32,
                                    ),
                                    Divider(
                                      height: 0.5,
                                      color: Get.theme.dividerColor
                                          .withValues(alpha: 0.02),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 16,
                                        bottom: 12,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            'add_schedule.form_data.reminder'
                                                .tr,
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                              color: Get.theme.hintColor,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            '*',
                                            style: Get
                                                .theme.textTheme.labelLarge
                                                ?.copyWith(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    _buildReminders(),
                                    SizedBox(
                                      height: 32,
                                    ),
                                  ],
                                )
                              : SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: Get.width,
                  height: 48,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.saveSchedule(back: true);
                        },
                        child: Text('btn.saveAndBack'.tr),
                      ),
                      const SizedBox(width: 16),
                      FilledButton(
                        onPressed: () {
                          controller.saveSchedule(back: false);
                        },
                        child: Text('btn.save'.tr),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
