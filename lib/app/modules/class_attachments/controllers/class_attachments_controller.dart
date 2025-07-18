import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
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
    required String fileName,
  }) async {
    if (fileName.endsWith('.txt')) {
      final attachment =
          await Get.toNamed(Routes.CREATE_ATTACHMENT, arguments: {
        'classId': classId.value,
        'attachmentId': attachmentId,
        'fileUrl': fileUrl,
        'fileName': fileName,
      });
      if (attachment != null) {
        await initAttachments();
      }
    } else {
      print('>>>>>>>>> fileUrl: $fileUrl');
      Get.toNamed(Routes.FILE_PREVIEWER, arguments: {
        'fileUrl': fileUrl,
        'fileName': fileName,
      });
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
        ),
        clipBehavior: Clip.hardEdge,
        child: Card(
          color: Get.theme.colorScheme.surface,
          margin: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    'class_attachments.from.upload'.tr,
                    style: Get.theme.textTheme.bodyLarge,
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
                onTap: () {
                  // uploadAttachment();
                  Get.back();
                  toastService.showLoading(
                    message: 'class_attachments.uploading'.tr,
                    asyncFunction: () async {
                      await uploadAttachment();
                    },
                  );
                },
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(
                  alpha: 0.04,
                ),
                indent: 8,
                endIndent: 8,
                thickness: 1,
              ),
              ListTile(
                title: Center(
                  child: Text(
                    'class_attachments.from.create'.tr,
                    style: Get.theme.textTheme.bodyLarge,
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
                tileColor: Get.theme.colorScheme.surface,
                onTap: () {
                  gotoUploadAttachment();
                },
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(
                  alpha: 0.04,
                ),
                indent: 8,
                endIndent: 8,
                thickness: 1,
              ),
              ListTile(
                title: Center(
                  child: Text(
                    'class_attachments.from.cancel'.tr,
                    style: Get.theme.textTheme.bodyLarge?.copyWith(
                      color: Get.theme.colorScheme.error,
                    ),
                  ),
                ),
                titleAlignment: ListTileTitleAlignment.center,
                tileColor: Get.theme.colorScheme.surface,
                onTap: () {
                  Get.back();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> gotoUploadAttachment() async {
    Get.back();
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

  void showUploading<T>({
    required Future<T> Function() asyncFunction,
  }) {
    Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: Center(
        child: LoaderOverlay(
          overlayColor: Colors.transparent,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4.5,
                      sigmaY: 4.5,
                    ),
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomLoader(
                              color: Get.theme.colorScheme.surface,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              'class_attachments.uploading'.tr,
                              textAlign: TextAlign.center,
                              style: Get.theme.textTheme.bodyMedium?.copyWith(
                                color: Get.theme.colorScheme.surface,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> uploadAttachment() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['txt', 'pdf', 'doc', 'docx'],
    );
    // final result = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (result != null && result.files.isNotEmpty) {
      NormalResponse response =
          await attachmentService.uploadAttachmentsByFiles(
        files: result.files.map((item) => XFile(item.path!)).toList(),
        classId: classId.value,
        className: classDetail.value.name,
        uploaderId: classDetail.value.teacherId ?? '',
        uploaderName: classDetail.value.teacherEnName ?? '',
      );

      print('>>>>>>>>>>>>>> response.data: ${response.data}');

      if (response.code == 200) {
        await initAttachments();
      } else {
        toastService.showError(message: 'class_attachments.upload.failed'.tr);
      }
    }
  }
}
