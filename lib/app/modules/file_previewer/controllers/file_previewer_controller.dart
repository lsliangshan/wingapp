import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class FilePreviewerController extends GetxController {
  InAppWebViewController? webViewController;

  late Future<void> initPreviewFuture;

  @override
  void onInit() {
    super.onInit();

    initPreviewFuture = initData();
  }

  @override
  void onClose() {
    super.onClose();

    webViewController?.dispose();
    webViewController = null;
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
