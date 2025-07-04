import 'package:get/get.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/services/localstorage.dart';

class ProfileController extends GetxController {
  final LocalstorageService localstorageService =
      Get.find<LocalstorageService>();

  RxString role = 'teacher'.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void initRole() async {
    String? localRole = await localstorageService.getString(LocalRoleKey);
    if (localRole == null || localRole.isEmpty) {
      localRole = 'teacher';
    }
    role.value = localRole;
  }
}
