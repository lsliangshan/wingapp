import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';

import '../controllers/file_previewer_controller.dart';

class FilePreviewerView extends GetView<FilePreviewerController> {
  final String fileUrl;
  final String fileName;
  const FilePreviewerView({
    super.key,
    required this.fileUrl,
    required this.fileName,
  });

  Widget renderChild() {
    if (fileName.endsWith('.pdf')) {
      return SfPdfViewer.network(fileUrl);
    }

    return InAppWebView(
      initialUrlRequest: URLRequest(
          url: WebUri(
              'https://viewer.liangqy.com?url=${Uri.encodeComponent(fileUrl)}')),
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        transparentBackground: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fileName,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: const CustomBackwardView(),
      ),
      // body: SfPdfViewer.network(
      //   fileUrl,
      // ),
      body: Container(
        child: renderChild(),
      ),
    );
  }
}
