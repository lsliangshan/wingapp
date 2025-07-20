import 'package:get/get.dart';

import '../controllers/choose_class_controller.dart';

class ChooseClassBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseClassController>(
      () => ChooseClassController(),
    );
  }
}
