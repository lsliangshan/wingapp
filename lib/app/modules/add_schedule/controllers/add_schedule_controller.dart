import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/class.dart';
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

  ReminderEntity({
    required this.before,
    required this.unit,
  });

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'before': before,
      'unit': unit,
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

  ToastService toastService = Get.find<ToastService>();
  ClassService classService = Get.find<ClassService>();
  TeacherService teacherService = Get.find<TeacherService>();
  DingtalkService dingtalkService = Get.find<DingtalkService>();

  final formKey = GlobalKey<FormState>();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();

  Rx<AddScheduleFormData> formData = AddScheduleFormData(
    classId: '',
    className: '',
    teacherUnionId: '',
    title: '',
    content: '',
    schedule: [],
    reminders: [],
  ).obs;

  List<Class> newClasses = [];

  Rx<XFile> classIcon = XFile('').obs;

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

  Future<void> initData() async {}

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
}
