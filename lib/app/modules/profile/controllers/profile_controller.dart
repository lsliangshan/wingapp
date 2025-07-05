import 'package:dingtalk_auth/dingtalk_auth.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/services/dingtalk.dart';
import 'package:wingapp/services/localstorage.dart';
import 'package:wingapp/services/teacher.dart';
import 'package:wingapp/services/toast.dart';

class ProfileController extends GetxController {
  final EventBus eventBus = Get.find<EventBus>();
  final LocalstorageService localstorageService =
      Get.find<LocalstorageService>();
  final DingtalkService dingtalkService = Get.find<DingtalkService>();
  TeacherService teacherService = Get.find<TeacherService>();
  ToastService toastService = Get.find<ToastService>();

  RxString role = 'teacher'.obs;

  RxBool isLoggedIn = false.obs;
  Rx<LoginInfo?> loginInfo = Rx<LoginInfo?>(null);

  RxBool isDingTalkLogining = false.obs;

  RxBool get isAdminTeacher => true.obs; // (loginInfo.value?.admin == '1').obs;

  @override
  void onInit() {
    super.onInit();

    initData();

    eventBus.on<LoginEvent>().listen((event) {
      loginInfo.value = event.loginInfo;
      isLoggedIn.value = true;
      update(['update-login-info']);
    });

    eventBus.on<LogoutEvent>().listen((event) {
      loginInfo.value = null;
      isLoggedIn.value = false;
      update(['update-login-info']);
    });
  }

  Future<void> initData() async {
    await initLoginInfo();
  }

  Future<void> initLoginInfo() async {
    loginInfo.value = await teacherService.getLoginInfo();
    isLoggedIn.value = await teacherService.isLoggedIn();

    update(['update-login-info']);
  }

  void dingTalkLogin() async {
    isDingTalkLogining.value = true;

    // 1. 获取钉钉 authCode
    const params = DingTalkAuthParam(
      appId: 'dingkbjfwewqmbaiz9uj',
      redirectUrl: 'http://192.168.1.11:5173/login',
    );
    final authCode = await DingtalkAuth.auth(params);
    if (authCode != null && authCode.isNotEmpty) {
      // 2. 获取钉钉用户信息
      final userInfo = await dingtalkService.getUserInfoByAuthCode(
        authCode: authCode,
      );

      if (userInfo.code == 200) {
        await teacherService.loginWithDingtalk(
          id: userInfo.data?['id'] ?? '',
          unionId: userInfo.data?['unionId'] ?? '',
          openId: userInfo.data?['openId'] ?? '',
          enName: userInfo.data?['enName'] ?? '',
          stateCode: userInfo.data?['stateCode'] ?? '',
          mobile: userInfo.data?['mobile'] ?? '',
        );
        toastService.showSuccess(message: 'toast.login.success'.tr);
      } else {
        toastService.showError(
            message: userInfo.message ?? 'toast.login.failed'.tr);
      }
    }
    // await teacherService.dingTalkLogin();
    isDingTalkLogining.value = false;
    update(['update-login-info']);
  }

  void logout() async {
    await teacherService.logout();
    toastService.showSuccess(message: 'toast.logout.success'.tr);
    update(['update-login-info']);
  }

  void initRole() async {
    String? localRole = await localstorageService.getString(LocalRoleKey);
    if (localRole == null || localRole.isEmpty) {
      localRole = 'teacher';
    }
    role.value = localRole;
  }

  void navigateToTeacherManage() {
    Get.toNamed(Routes.TEACHER);
  }
}
