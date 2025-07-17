import 'package:get/get.dart';

import '../controllers/create_attachment_controller.dart';

class CreateAttachmentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateAttachmentController>(
      () => CreateAttachmentController(),
    );
  }
}
