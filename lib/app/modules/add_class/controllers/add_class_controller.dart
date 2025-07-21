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

class AddClassFormData {
  String? name;
  String? icon;
  String? teacherId;
  String? teacherName;
  String? teacherEnName;
  String? teacherUnionId;

  AddClassFormData({
    this.name,
    this.icon,
    this.teacherId,
    this.teacherName,
    this.teacherEnName,
    this.teacherUnionId,
  });

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'icon': icon,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'teacherEnName': teacherEnName,
      'teacherUnionId': teacherUnionId,
    };
  }
}

class AddClassController extends GetxController {
  ToastService toastService = Get.find<ToastService>();
  ClassService classService = Get.find<ClassService>();
  TeacherService teacherService = Get.find<TeacherService>();
  DingtalkService dingtalkService = Get.find<DingtalkService>();

  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();

  Rx<AddClassFormData> formData = AddClassFormData(
    name: '',
    icon: '',
    teacherId: '',
    teacherName: '',
    teacherEnName: '',
    teacherUnionId: '',
  ).obs;

  List<Class> newClasses = [];

  Rx<XFile> classIcon = XFile('').obs;

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() {
      formData.value.name = nameController.text;
      update(['update-form-data']);
    });
  }

  Future<void> chooseTeacher() async {
    final result = await Get.toNamed(Routes.CHOOSE_TEACHER, arguments: {
      'teacherId': formData.value.teacherId,
    });
    if (result != null) {
      formData.value.teacherId = result.id;
      formData.value.teacherName = result.name;
      formData.value.teacherEnName = result.enName;
      formData.value.teacherUnionId = result.unionId;
      update(['update-form-data']);
    }
  }

  void clearFormData() {
    nameController.clear();
    formData.value = AddClassFormData(
      name: '',
      icon: '',
      teacherId: '',
      teacherName: '',
      teacherEnName: '',
      teacherUnionId: '',
    );
    update(['update-form-data']);
  }

  Future<void> saveClass({
    bool back = false,
  }) async {
    if (formData.value.name == null || formData.value.name!.isEmpty) {
      toastService.showError(
        message: 'toast.add_class.name_required'.tr,
      );
      nameFocusNode.requestFocus();
      return;
    }

    NormalResponse response = await classService.addClass(
      name: formData.value.name!,
      icon: formData.value.icon,
      teacherId: formData.value.teacherId!,
      teacherName: formData.value.teacherName!,
      teacherEnName: formData.value.teacherEnName!,
      teacherUnionId: formData.value.teacherUnionId!,
    );

    if (response.code == 200) {
      toastService.showSuccess(
        message: 'toast.add_class.save.success'.tr,
      );
      newClasses.add(Class.fromJson(response.data));

      if (back) {
        Get.back(result: newClasses);
      } else {
        clearFormData();
      }
    } else {
      toastService.showError(
        message: response.message ?? 'toast.add_class.save.fail'.tr,
      );
    }
  }

  Future<void> uploadClassIcon() async {
    final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null) {
      classIcon.value = result;
      NormalResponse response = await dingtalkService.uploadFile(
        file: classIcon.value,
      );

      if (response.code == 200) {
        formData.value.icon = response.data['mediaId'];
        update(['update-form-data']);
      }
    }
  }
}
