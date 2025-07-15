import 'package:get/get.dart';

import '../controllers/class_attachments_controller.dart';

class ClassAttachmentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassAttachmentsController>(
      () => ClassAttachmentsController(),
    );
  }
}
