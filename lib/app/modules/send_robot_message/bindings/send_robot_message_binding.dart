import 'package:get/get.dart';

import '../controllers/send_robot_message_controller.dart';

class SendRobotMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendRobotMessageController>(
      () => SendRobotMessageController(),
    );
  }
}
