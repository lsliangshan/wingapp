import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class FilePreviewerController extends GetxController {
  InAppWebViewController? webViewController;

  TextEditingController fileNameController = TextEditingController();

  FocusNode fileNameFocusNode = FocusNode();

  late Future<void> initPreviewFuture;

  @override
  void onInit() {
    super.onInit();

    initPreviewFuture = initData();
  }

  Future<void> initData() async {}

  void onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;

    controller.addJavaScriptHandler(
      handlerName: "changeContent",
      callback: (args) async {
        print('>>>>> changeContent: ${args[0]}');
        return {
          "code": 200,
        };
      },
    );
  }
}
