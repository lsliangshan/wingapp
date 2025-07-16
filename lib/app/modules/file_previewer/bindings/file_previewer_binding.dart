import 'package:get/get.dart';

import '../controllers/file_previewer_controller.dart';

class FilePreviewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilePreviewerController>(
      () => FilePreviewerController(),
    );
  }
}
