import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';

import '../controllers/create_attachment_controller.dart';

class CreateAttachmentView extends GetView<CreateAttachmentController> {
  final String classId;
  final String? fileUrl;
  final String? fileName;
  const CreateAttachmentView({
    super.key,
    required this.classId,
    this.fileUrl,
    this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: EditableText(
          controller: controller.fileNameController,
          focusNode: controller.fileNameFocusNode,
          onTapOutside: (event) {
            controller.fileNameFocusNode.unfocus();
          },
          readOnly: controller.mode.value == 'edit',
          style: Get.theme.textTheme.titleMedium!,
          cursorColor: Get.theme.colorScheme.primary,
          backgroundCursorColor: Get.theme.colorScheme.primary,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: const CustomBackwardView(),
        actions: [
          Obx(() => TextButton(
                onPressed: controller.isCreating.value
                    ? null
                    : () {
                        controller.saveAttachment();
                      },
                child: controller.isCreating.value
                    ? CustomLoader(
                        size: 8,
                      )
                    : Text('create_attachment.btn.save'.tr),
              )),
        ],
      ),
      body: FutureBuilder(
        future: controller.initCreateAttachmentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CustomLoader(),
            );
          }

          return SingleChildScrollView(
            child: TextFormField(
              controller: controller.fileContentController,
              focusNode: controller.fileContentFocusNode,
              onTapOutside: (event) {
                controller.fileContentFocusNode.unfocus();
              },
              maxLines: null,
              minLines: 60,
              style: Get.theme.textTheme.bodyLarge,
              cursorColor: Get.theme.colorScheme.primary,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'create_attachment.file_content.hint'.tr,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
