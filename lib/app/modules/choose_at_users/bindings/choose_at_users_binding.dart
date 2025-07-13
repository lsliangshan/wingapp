import 'package:get/get.dart';

import '../controllers/choose_at_users_controller.dart';

class ChooseAtUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseAtUsersController>(
      () => ChooseAtUsersController(),
    );
  }
}
