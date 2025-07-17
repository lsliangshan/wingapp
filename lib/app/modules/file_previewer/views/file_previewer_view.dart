import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';

import '../controllers/file_previewer_controller.dart';

class FilePreviewerView extends GetView<FilePreviewerController> {
  final String fileUrl;
  final String? fileName;
  const FilePreviewerView({
    super.key,
    required this.fileUrl,
    this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fileName ?? 'file_previewer.title'.tr,
          style: Get.theme.textTheme.titleMedium,
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
