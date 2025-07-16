import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';

import '../controllers/file_previewer_controller.dart';

class FilePreviewerView extends GetView<FilePreviewerController> {
  final String fileUrl;
  final String? fileName;
  final String? mode;
  FilePreviewerView({
    super.key,
    required this.fileUrl,
    this.fileName,
    this.mode,
  }) {
    controller.fileNameController.text = fileName ?? 'file_previewer.title'.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   fileName ?? 'file_previewer.title'.tr,
        //   style: Get.theme.textTheme.titleMedium,
        // ),
        title: Container(
          width: Get.width - 200,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EditableText(
                controller: controller.fileNameController,
                focusNode: controller.fileNameFocusNode,
                onTapOutside: (event) {
                  controller.fileNameFocusNode.unfocus();
                },
                textAlign: TextAlign.center,
                style: Get.theme.textTheme.titleMedium!,
                cursorColor: Get.theme.primaryColor,
                backgroundCursorColor: Get.theme.primaryColor,
              ),
              Text('.txt')
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: const CustomBackwardView(),
        actions: [
          IconButton(
            onPressed: () {
              controller.fileNameFocusNode.unfocus();
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      // body: SfPdfViewer.network(
      //   fileUrl,
      // ),
      body: InAppWebView(
        initialUrlRequest: URLRequest(
            url: WebUri(
                "http://192.168.1.4:5173/file-viewer?url=${Uri.encodeComponent(fileUrl)}")),
        initialSettings: InAppWebViewSettings(
          javaScriptEnabled: true,
          transparentBackground: true,
          useWideViewPort: true,
          enableViewportScale: true,
        ),
        onWebViewCreated: controller.onWebViewCreated,
      ),
    );
  }
}
