import 'package:get/get.dart';

import '../controllers/choose_teacher_controller.dart';

class ChooseTeacherBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseTeacherController>(
      () => ChooseTeacherController(),
    );
  }
}
