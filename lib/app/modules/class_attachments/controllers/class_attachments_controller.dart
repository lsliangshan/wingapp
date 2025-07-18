import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/attachment_entity.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/attachment.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/toast.dart';

class ClassAttachmentsController extends GetxController {
  final ClassService classService = Get.find<ClassService>();
  final ToastService toastService = Get.find<ToastService>();
  final AttachmentService attachmentService = Get.find<AttachmentService>();

  late Future<void> initClassAttachmentsFuture;

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

  RxList<AttachmentEntity> attachments = RxList<AttachmentEntity>();

  @override
  void onInit() {
    super.onInit();

    initClassAttachmentsFuture = initData();
  }

  Future<void> initData() async {
    if (Get.arguments != null && Get.arguments['classId'] != null) {
      classId.value = Get.arguments['classId'];
    }

    await initClassDetail();

    await initAttachments();

    return await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> initClassDetail() async {
    NormalResponse normalResponse = await classService.getClassDetailByClassId(
      classId: classId.value,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      classDetail.value = Class.fromJson(normalResponse.data!);
      update(['update-class-attachments']);
    } else {
      toastService.showError(message: 'class_detail.init.failed'.tr);
    }
  }

  Future<void> onRefresh() async {
    await initAttachments();

    return await Future.delayed(const Duration(milliseconds: 1000));
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
      update(['update-class-attachments']);
    }
  }

  Future<void> gotoFilePreviewer({
    required String fileUrl,
    required String attachmentId,
    String? fileName,
  }) async {
    final attachment = await Get.toNamed(Routes.CREATE_ATTACHMENT, arguments: {
      'classId': classId.value,
      'attachmentId': attachmentId,
      'fileUrl': fileUrl,
      'fileName': fileName ?? '',
    });
    if (attachment != null) {
      await initAttachments();
    }
  }

  Future<void> gotoCreateAttachment() async {
    Get.bottomSheet(
      Container(
        height: 200,
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          color: Get.theme.colorScheme.surface,
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text('class_attachments.from.upload'.tr),
              titleAlignment: ListTileTitleAlignment.center,
              onTap: () {},
            ),
            ListTile(
              title: Text('class_attachments.from.create'.tr),
              titleAlignment: ListTileTitleAlignment.center,
              onTap: () {},
            ),
            ListTile(
              title: Text('class_attachments.from.cancel'.tr),
              titleAlignment: ListTileTitleAlignment.center,
              onTap: () {},
            ),
          ],
        ),
      ),
    );

    return;

    final attachment = await Get.toNamed(
      Routes.CREATE_ATTACHMENT,
      arguments: {
        'classId': classId.value,
      },
    );

    if (attachment != null) {
      await initAttachments();
    }
  }
}
