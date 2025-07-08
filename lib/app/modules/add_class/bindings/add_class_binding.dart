import 'package:get/get.dart';

import '../controllers/add_class_controller.dart';

class AddClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddClassController>(
      () => AddClassController(),
    );
  }
}
