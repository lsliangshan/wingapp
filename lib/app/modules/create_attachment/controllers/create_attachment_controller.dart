import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/attachment_entity.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/attachment.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/toast.dart';

class CreateAttachmentController extends GetxController {
  AttachmentService attachmentService = Get.find<AttachmentService>();
  ClassService classService = Get.find<ClassService>();
  ToastService toastService = Get.find<ToastService>();

  late Future<void> initCreateAttachmentFuture;

  TextEditingController fileNameController =
      TextEditingController(text: 'create_attachment.default_name'.tr);

  TextEditingController fileContentController = TextEditingController();

  FocusNode fileNameFocusNode = FocusNode();
  FocusNode fileContentFocusNode = FocusNode();

  Rx<String> classId = ''.obs;

  Rx<Class> classDetail = Class(
    id: "",
    name: "",
    icon: "",
    teacherId: "",
    teacherUnionId: "",
    teacherName: "",
    teacherEnName: "",
    robotCode: "",
    openConversationId: "",
    chatId: "",
    link: "",
    assistant: "",
    createAt: "",
    updateAt: "",
  ).obs;

  Rx<bool> isCreating = false.obs;

  @override
  void onInit() {
    super.onInit();

    initCreateAttachmentFuture = initData();
  }

  Future<void> initData() async {
    if (Get.arguments != null && Get.arguments['classId'] != null) {
      classId.value = Get.arguments['classId'];
    }

    await initClassDetail();

    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> initClassDetail() async {
    NormalResponse normalResponse = await classService.getClassDetailByClassId(
      classId: classId.value,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      classDetail.value = Class.fromJson(normalResponse.data!);
      update(['update-class-detail']);
    } else {
      toastService.showError(message: 'class_detail.init.failed'.tr);
    }
  }

  Future<void> saveAttachment() async {
    if (fileNameController.text.isEmpty ||
        fileNameController.text.trim() == 'create_attachment.default_name'.tr) {
      toastService.showError(
          message: 'create_attachment.valid.name.cannot_empty'.tr);
      fileNameFocusNode.requestFocus();
      return;
    }

    if (isCreating.value) {
      return;
    }
    isCreating.value = true;

    NormalResponse normalResponse = await attachmentService.uploadAttachment(
      content: fileContentController.text,
      filename: fileNameController.text,
      classId: classId.value,
      className: classDetail.value.name,
      uploaderId: classDetail.value.teacherId ?? '',
      uploaderName: classDetail.value.teacherEnName ?? '',
    );
    if (normalResponse.code == 200) {
      print('>>>>>>>> 添加成功: ${normalResponse.data}');
      Get.back(result: AttachmentEntity.fromJson(normalResponse.data!));
      toastService.showSuccess(message: 'create_attachment.save.success'.tr);
    } else {
      print('>>>>>>>> 添加失败: ${normalResponse.data}');
      toastService.showError(message: 'create_attachment.save.failed'.tr);
    }

    isCreating.value = false;
  }
}
