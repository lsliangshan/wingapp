import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  Rx<String> mode = 'create'.obs;

  Rx<String> classId = ''.obs;

  Rx<String> attachmentId = ''.obs;

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

  RxList<AttachmentEntity> attachments = RxList<AttachmentEntity>();

  @override
  void onInit() {
    super.onInit();

    initCreateAttachmentFuture = initData();
  }

  Future<void> initAttachments() async {
    NormalResponse normalResponse = await attachmentService.getAttachments(
      classId: classId.value,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      if (normalResponse.data!['list'] != null &&
          normalResponse.data!['list'].isNotEmpty) {
        attachments.value = normalResponse.data!['list']
            .map<AttachmentEntity>((e) => AttachmentEntity.fromJson(e))
            .toList();
      } else {
        // 无数据
      }
    }
  }

  Future<void> initData() async {
    if (Get.arguments != null && Get.arguments['classId'] != null) {
      classId.value = Get.arguments['classId'];
    }
    if (Get.arguments != null && Get.arguments['fileName'] != null) {
      fileNameController.text =
          Get.arguments['fileName'].replaceAll(RegExp(r'\.txt$'), '');
    }
    if (Get.arguments != null && Get.arguments['attachmentId'] != null) {
      mode.value = 'edit';
      attachmentId.value = Get.arguments['attachmentId'];
    }
    if (Get.arguments != null && Get.arguments['fileUrl'] != null) {
      fileContentController.text = await attachmentService.getFileContent(
        fileUrl: Get.arguments['fileUrl'],
      );
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

    if (mode.value == 'create') {
      await initAttachments();

      if (attachments.any((element) =>
          element.filename.replaceAll(RegExp(r'\.txt$'), '') ==
          fileNameController.text)) {
        toastService.showError(
            message: 'create_attachment.valid.name.already_exists'.tr);
        fileNameFocusNode.requestFocus();
        return;
      }
    }

    isCreating.value = true;

    NormalResponse normalResponse = await attachmentService.uploadAttachment(
      attachmentId: attachmentId.value,
      content: fileContentController.text,
      filename: fileNameController.text,
      classId: classId.value,
      className: classDetail.value.name,
      uploaderId: classDetail.value.teacherId ?? '',
      uploaderName: classDetail.value.teacherEnName ?? '',
    );
    if (normalResponse.code == 200) {
      Get.back(
          result: AttachmentEntity.fromJson({
        ...(normalResponse.data!),
        'updateAt': DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now()),
      }));
      toastService.showSuccess(message: 'create_attachment.save.success'.tr);
    } else {
      toastService.showError(message: 'create_attachment.save.failed'.tr);
    }

    isCreating.value = false;
  }
}
