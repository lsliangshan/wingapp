import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/date.dart';
import 'package:wingapp/services/dingtalk.dart';
import 'package:wingapp/services/schedule.dart';
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

  static ScheduleEntity fromJson(Map<String, dynamic> json) {
    return ScheduleEntity(
      date: DateTime.parse(json['date'] ?? json['start']),
      range: [DateTime.parse(json['start']), DateTime.parse(json['end'])],
      repeats: json['repeats'],
    );
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

  static ReminderEntity fromJson(Map<String, dynamic> json) {
    return ReminderEntity(
      before: json['before'],
      unit: json['unit'],
      id: json['id'],
    );
  }
}

class AddScheduleFormData {
  String formId;
  String classId;
  String className;
  String teacherUnionId;
  String title;
  String content;
  List<ScheduleEntity> schedule;
  List<ReminderEntity> reminders;

  AddScheduleFormData({
    required this.formId,
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
      'formId': formId,
      'classId': classId,
      'className': className,
      'teacherUnionId': teacherUnionId,
      'title': title,
      'content': content,
      'schedule': schedule.map((e) => e.toJson()).toList(),
      'reminders': reminders.map((e) => e.toJson()).toList(),
    };
  }

  static AddScheduleFormData fromJson(Map<String, dynamic> json) {
    return AddScheduleFormData(
      formId: json['formId'],
      classId: json['classId'],
      className: json['className'],
      teacherUnionId: json['teacherUnionId'],
      title: json['title'],
      content: json['content'],
      schedule:
          json['schedule'].map((e) => ScheduleEntity.fromJson(e)).toList(),
      reminders:
          json['reminders'].map((e) => ReminderEntity.fromJson(e)).toList(),
    );
  }
}

class AddScheduleController extends GetxController {
  // 如果有 classId，则表示是添加班级，老师信息不能修改;否则是管理员添加班级
  final String? classId;
  final String? formId;
  AddScheduleController({this.classId, this.formId});

  DateService dateService = Get.find<DateService>();
  ToastService toastService = Get.find<ToastService>();
  ClassService classService = Get.find<ClassService>();
  TeacherService teacherService = Get.find<TeacherService>();
  DingtalkService dingtalkService = Get.find<DingtalkService>();
  ScheduleService scheduleService = Get.find<ScheduleService>();

  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  Map<String, TextEditingController> reminderControllers = {};
  Map<String, FocusNode> reminderFocusNodes = {};

  Rx<AddScheduleFormData> formData = AddScheduleFormData(
    formId: '',
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

  // List<ScheduleEntity> newSchedules = [];

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

    if (formId != null && formId!.isNotEmpty) {
      formData.value.formId = formId!;
    } else {
      formData.value.formId = Uuid().v4();
    }

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

    if (classId != null && classId!.isNotEmpty) {
      formData.value.classId = classId!;
      await getClassInfo();
    }

    if (formId != null && formId!.isNotEmpty) {
      await initScheduleDetail(id: formId!);
    }
  }

  void clearFormData() {
    titleController.clear();
    contentController.clear();
    formData.value = AddScheduleFormData(
      formId: Uuid().v4(),
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

  Future<void> getClassInfo() async {
    NormalResponse response = await classService.getClassDetailByClassId(
      classId: formData.value.classId,
    );

    if (response.code == 200) {
      formData.value.className = response.data['name'];
    }
  }

  Future<void> initScheduleDetail({
    required String id,
  }) async {
    NormalResponse response = await scheduleService.getScheduleDetailByFormId(
      formId: id,
    );

    if (response.code == 200 &&
        response.data != null &&
        response.data["list"] != null &&
        response.data["list"].length > 0) {
      try {
        formData.value = AddScheduleFormData(
          formId: response.data['list'][0]['formId'],
          classId: response.data['list'][0]['classId'],
          className: response.data['list'][0]['className'],
          teacherUnionId: response.data['list'][0]['teacherUnionId'],
          title: response.data['list'][0]['title'],
          content: response.data['list'][0]['content'],
          schedule: [],
          reminders: response.data['list'][0]['reminders']
              .split(';')
              .map<ReminderEntity>((e) => ReminderEntity(
                    before: int.tryParse(e.split('-').first) ?? 30,
                    unit: e.split('-').last,
                    id: Uuid().v4(),
                  ))
              .toList(),
        );
        formData.value.schedule = response.data['list']
            .map<ScheduleEntity>((e) => ScheduleEntity(
                  date: DateTime.parse(e['start']),
                  range: [
                    DateTime.parse(e['start']),
                    DateTime.parse(e['end']),
                  ],
                  repeats: e['repeats'] == '1',
                ))
            .toList();
      } catch (_) {}

      titleController.text = formData.value.title;
      contentController.text = formData.value.content;

      initReminderControllers();
      update(['update-form-data']);
    }
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

    NormalResponse response = await scheduleService.addSchedule(
      formId: Uuid().v4(),
      classId: formData.value.classId,
      className: formData.value.className,
      teacherUnionId: formData.value.teacherUnionId,
      title: formData.value.title,
      content: formData.value.content,
      schedule: formData.value.schedule.map((e) {
        return {
          'start': DateFormat('yyyy-MM-dd HH:mm:ss').format(e.range[0]),
          'end': DateFormat('yyyy-MM-dd HH:mm:ss').format(e.range[1]),
          'repeats': e.repeats,
          'dayOfWeek': DateFormat('EEEE', 'en').format(e.date).toLowerCase(),
        };
      }).toList(),
      reminders: formData.value.reminders.map((e) => e.toJson()).toList(),
    );

    if (response.code == 200) {
      toastService.showSuccess(
        message: 'toast.add_schedule.save.success'.tr,
      );
      // newSchedules.add(ScheduleEntity.fromJson(
      //   Map<String, dynamic>.from(response.data),
      // ));

      if (back) {
        Get.back(result: true);
      } else {
        clearFormData();
      }
    } else {
      toastService.showError(
        message: response.message ?? 'toast.add_schedule.save.fail'.tr,
      );
      if (response.code == 1002) {
        titleFocusNode.requestFocus();
      }
    }
  }

  Future<void> chooseClass() async {
    final result = await Get.toNamed(
      Routes.CHOOSE_CLASS,
      arguments: {
        'classId': formData.value.classId,
      },
    );
    if (result != null && result['classInfo'] != null) {
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
