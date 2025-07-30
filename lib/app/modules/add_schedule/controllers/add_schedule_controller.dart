import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/date.dart';
import 'package:wingapp/services/dingtalk.dart';
import 'package:wingapp/services/teacher.dart';
import 'package:wingapp/services/toast.dart';

class ScheduleEntity {
  DateTime date;
  List<DateTime> range;
  bool repeats;

  ScheduleEntity({
    required this.date,
    required this.range,
    required this.repeats,
  });

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'range': range,
      'repeats': repeats,
    };
  }
}

class ReminderEntity {
  int before;
  String unit;
  String id;

  ReminderEntity({
    required this.before,
    required this.unit,
    required this.id,
  });

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'before': before,
      'unit': unit,
      'id': id,
    };
  }
}

class AddScheduleFormData {
  String classId;
  String className;
  String teacherUnionId;
  String title;
  String content;
  List<ScheduleEntity> schedule;
  List<ReminderEntity> reminders;

  AddScheduleFormData({
    required this.classId,
    required this.className,
    required this.teacherUnionId,
    required this.title,
    required this.content,
    required this.schedule,
    required this.reminders,
  });

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'classId': classId,
      'className': className,
      'teacherUnionId': teacherUnionId,
      'title': title,
      'content': content,
      'schedule': schedule.map((e) => e.toJson()).toList(),
      'reminders': reminders.map((e) => e.toJson()).toList(),
    };
  }
}

class AddScheduleController extends GetxController {
  // 如果有 teacherId，则表示是老师添加班级，老师信息不能修改;否则是管理员添加班级
  final String? teacherId;
  AddScheduleController({this.teacherId});

  DateService dateService = Get.find<DateService>();
  ToastService toastService = Get.find<ToastService>();
  ClassService classService = Get.find<ClassService>();
  TeacherService teacherService = Get.find<TeacherService>();
  DingtalkService dingtalkService = Get.find<DingtalkService>();

  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  Map<String, TextEditingController> reminderControllers = {};
  Map<String, FocusNode> reminderFocusNodes = {};

  Rx<AddScheduleFormData> formData = AddScheduleFormData(
    classId: '',
    className: '',
    teacherUnionId: '',
    title: '',
    content: '',
    schedule: [
      ScheduleEntity(
        date: DateTime.now(),
        range: [DateTime.now(), DateTime.now()],
        repeats: true,
      ),
    ],
    reminders: [
      ReminderEntity(
        before: 30,
        unit: 'minute',
        id: '1',
      ),
    ],
  ).obs;

  List<Class> newClasses = [];

  late Future<void> initAddClassFuture;

  @override
  void onInit() {
    super.onInit();
    titleController.addListener(() {
      formData.value.title = titleController.text;
      update(['update-form-data']);
    });

    contentController.addListener(() {
      formData.value.content = contentController.text;
      update(['update-form-data']);
    });

    initAddClassFuture = initData();
  }

  void destoryReminderControllers() {
    for (ReminderEntity reminder in formData.value.reminders) {
      reminderControllers[reminder.id]?.dispose();
      reminderFocusNodes[reminder.id]?.dispose();
    }
  }

  void initReminderControllers() {
    destoryReminderControllers();
    for (ReminderEntity reminder in formData.value.reminders) {
      reminderControllers[reminder.id] = TextEditingController(
        text: '${reminder.before}',
      );
      reminderFocusNodes[reminder.id] = FocusNode();

      reminderFocusNodes[reminder.id]!.addListener(() {
        if (!reminderFocusNodes[reminder.id]!.hasFocus) {
          if (reminderControllers[reminder.id]!.text.isNotEmpty) {
            reminder.before = int.parse(reminderControllers[reminder.id]!.text);
          } else {
            reminder.before = 1;
          }
          reminderControllers[reminder.id]!.text = '${reminder.before}';
          update(['update-form-data']);
        }
      });
    }
  }

  Future<void> initData() async {
    initReminderControllers();
  }

  void clearFormData() {
    titleController.clear();
    contentController.clear();
    formData.value = AddScheduleFormData(
      classId: '',
      className: '',
      teacherUnionId: '',
      title: '',
      content: '',
      schedule: [],
      reminders: [],
    );
    update(['update-form-data']);
  }

  Future<void> saveSchedule({
    bool back = false,
  }) async {
    if (formData.value.classId.isEmpty) {
      toastService.showError(
        message: 'toast.add_schedule.class_required'.tr,
      );
      return;
    }

    if (formData.value.title.isEmpty) {
      toastService.showError(
        message: 'toast.add_schedule.title_required'.tr,
      );
      titleFocusNode.requestFocus();
      return;
    }

    if (formData.value.content.isEmpty) {
      toastService.showError(
        message: 'toast.add_schedule.content_required'.tr,
      );
      contentFocusNode.requestFocus();
      return;
    }

    print('>>>>>>>>>>>>>>>>>>>> ${formData.value.toJson()}');

    // NormalResponse response = await classService.addClass(
    //   name: formData.value.name!,
    //   icon: formData.value.icon,
    //   teacherId: formData.value.teacherId!,
    //   teacherName: formData.value.teacherName!,
    //   teacherEnName: formData.value.teacherEnName!,
    //   teacherUnionId: formData.value.teacherUnionId!,
    // );

    // if (response.code == 200) {
    //   toastService.showSuccess(
    //     message: 'toast.add_class.save.success'.tr,
    //   );
    //   newClasses.add(Class.fromJson(response.data));

    //   if (back) {
    //     Get.back(result: newClasses);
    //   } else {
    //     clearFormData();
    //   }
    // } else {
    //   toastService.showError(
    //     message: response.message ?? 'toast.add_class.save.fail'.tr,
    //   );
    //   if (response.code == 1002) {
    //     nameFocusNode.requestFocus();
    //   }
    // }
  }

  Future<void> chooseClass() async {
    final result = await Get.toNamed(
      Routes.CHOOSE_CLASS,
      arguments: {
        'classId': formData.value.classId,
      },
    );
    if (result != null && result['classInfo'] != null) {
      print('>>>>>>>>> chooseClass: ${result["classInfo"]}');
      formData.value.classId = result['classInfo'].id;
      formData.value.className = result['classInfo'].name;
      formData.value.teacherUnionId = result['classInfo'].teacherUnionId;
      update(['update-form-data']);
    }
  }

  void clearTitle() {
    titleController.clear();
    formData.value.title = '';
    update(['update-form-data']);
  }

  void clearContent() {
    contentController.clear();
    formData.value.content = '';
    update(['update-form-data']);
  }

  Future<void> changeDate(ScheduleEntity schedule) async {
    DateTime? result = await dateService.showDatePicker(
      initialDate: schedule.date,
    );
    if (result != null) {
      schedule.date = result;
      update(['update-form-data']);
    }
  }

  Future<void> changeTime(ScheduleEntity schedule) async {
    final result = await dateService.showDatetimeRangePicker(
      startDate: schedule.range[0],
      endDate: schedule.range[1],
    );
    if (result != null) {
      schedule.range = [result.start, result.end];
      update(['update-form-data']);
    }
  }

  void insertTemplateAtCursor({
    required String template,
  }) {
    contentFocusNode.requestFocus();

    String text = contentController.text;
    int cursor = contentController.selection.baseOffset;
    contentController.text =
        text.substring(0, cursor) + template + text.substring(cursor);
    contentController.selection = TextSelection.fromPosition(
        TextPosition(offset: cursor + template.length));
    update(['update-form-data']);
  }

  void addScheduleTime() {
    formData.value.schedule.add(ScheduleEntity(
      date: DateTime.now(),
      range: [DateTime.now(), DateTime.now()],
      repeats: true,
    ));
    update(['update-form-data']);
  }

  void removeSchedule(ScheduleEntity schedule) {
    formData.value.schedule.remove(schedule);
    update(['update-form-data']);
  }

  void removeReminder(ReminderEntity reminder) {
    formData.value.reminders.remove(reminder);
    reminderControllers.remove(reminder.id);
    reminderFocusNodes.remove(reminder.id);
    update(['update-form-data']);
  }

  void addReminder() {
    formData.value.reminders.add(ReminderEntity(
      before: 30,
      unit: 'minute',
      id: Uuid().v4(),
    ));
    initReminderControllers();
    update(['update-form-data']);
  }

  void changeReminderUnit(ReminderEntity reminder) {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('bottom_sheet.choose_reminder_unit.title'.tr),
                trailing: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    'assets/svgs/icon_close.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Get.theme.hintColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(alpha: 0.1),
              ),
              Container(
                height: 264,
                padding: const EdgeInsets.only(bottom: 32),
                child: ListView.builder(
                  itemCount: reminderUnits.length,
                  itemExtent: 48,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(reminderUnits[index]['label']!.tr),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      trailing: reminder.unit == reminderUnits[index]['value']
                          ? SvgPicture.asset(
                              'assets/svgs/icon_checked.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                Get.theme.primaryColor,
                                BlendMode.srcIn,
                              ),
                            )
                          : null,
                      onTap: () {
                        reminder.unit = reminderUnits[index]['value']!;
                        if (reminder.unit == 'hour') {
                          if (reminder.before > 672) {
                            reminder.before = 672;
                          }
                        } else if (reminder.unit == 'day') {
                          if (reminder.before > 28) {
                            reminder.before = 28;
                          }
                        } else if (reminder.unit == 'week') {
                          if (reminder.before > 4) {
                            reminder.before = 4;
                          }
                        }
                        reminderControllers[reminder.id]!.text =
                            '${reminder.before}';
                        update(['update-form-data']);
                        Get.back();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
