import 'package:dingtalk_auth/dingtalk_auth.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/app/modules/class/views/class_view.dart';
import 'package:wingapp/app/modules/student/views/student_view.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/models/normal_response.model.dart';
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

  RxBool get isAdminTeacher => (loginInfo.value?.admin == '1').obs;

  Rx<Map<String, dynamic>?> summaryCounts = Rx<Map<String, dynamic>?>(null);

  RxString currentLanguage = 'zh_CN'.obs;

  @override
  void onInit() {
    super.onInit();

    initLanguage();

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

    eventBus.on<NeedLoginEvent>().listen((event) {
      dingTalkLogin(
        onSuccess: () {
          eventBus.fire(NeedLoginCallbackEvent(isSuccess: true));
        },
        onFailed: () {
          eventBus.fire(NeedLoginCallbackEvent(isSuccess: false));
        },
      );
    });
  }

  Future<void> initData() async {
    await initLoginInfo();

    await initSummaryCounts();
  }

  Future<void> initLoginInfo() async {
    loginInfo.value = await teacherService.getLoginInfo();
    if (loginInfo.value != null) {
      eventBus.fire(LoginEvent(loginInfo.value!));
    }
    isLoggedIn.value = await teacherService.isLoggedIn();

    update(['update-login-info']);
  }

  Future<void> initLanguage() async {
    String localLanguage =
        (await localstorageService.getString(LocalLanguageKey)) ?? '';
    currentLanguage.value =
        (localLanguage != '') ? localLanguage : languages[0]['value']!;
  }

  Future<void> initSummaryCounts() async {
    if (!isLoggedIn.value) {
      return;
    }
    final response = await teacherService.getSummayCounts(
      teacherId: loginInfo.value?.id,
    );
    if (response.code == 200) {
      summaryCounts.value = response.data;
    } else {
      summaryCounts.value = {
        'teacherCount': '0',
        'studentCount': '0',
        'classCount': '0',
        'scheduleCount': '0',
      };
    }
    update(['update-summary-counts']);
  }

  void dingTalkLogin({
    Function()? onSuccess,
    Function()? onFailed,
  }) async {
    isDingTalkLogining.value = true;

    // 1. 获取钉钉 authCode
    const params = DingTalkAuthParam(
      appId: 'dingeoe1icdmqtkgnn33',
      redirectUrl: 'http://10.2.6.210:5173/dingtalk/login',
    );
    final authCode = await DingtalkAuth.auth(params);
    if (authCode != null && authCode.isNotEmpty) {
      // 2. 获取钉钉用户信息
      final userInfo = await dingtalkService.getUserInfoByAuthCode(
        authCode: authCode,
      );

      if (userInfo.code == 200) {
        NormalResponse response = await teacherService.loginWithDingtalk(
          id: userInfo.data?['id'] ?? '',
          unionId: userInfo.data?['unionId'] ?? '',
          openId: userInfo.data?['openId'] ?? '',
          enName: userInfo.data?['enName'] ?? '',
          stateCode: userInfo.data?['stateCode'] ?? '86',
          mobile: userInfo.data?['mobile'] ?? '',
        );
        if (response.code == 200) {
          initLoginInfo();
          toastService.showSuccess(message: 'toast.login.success'.tr);
          if (onSuccess != null) {
            onSuccess();
          }
        } else {
          toastService.showError(
              message: response.message ?? 'toast.login.failed'.tr);
          if (onFailed != null) {
            onFailed();
          }
        }
      } else {
        toastService.showError(
            message: userInfo.message ?? 'toast.login.failed'.tr);
        if (onFailed != null) {
          onFailed();
        }
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

  void navigateToTeacherManage() async {
    await Get.toNamed(Routes.TEACHER);
    initSummaryCounts();
  }

  void navigateToClassManage() async {
    await Get.to(
      () => ClassView(
        teacherId: loginInfo.value?.id ?? '',
      ),
    );
    initSummaryCounts();
  }

  Future<void> onRefresh() async {
    await initSummaryCounts();
  }

  void gotoDetail({required String type}) {
    switch (type) {
      case 'teacher':
        Get.toNamed(Routes.TEACHER);
        break;
      case 'student':
        Get.to(
          () => StudentView(
            teacherId: loginInfo.value?.id ?? '',
          ),
        );
        break;
      case 'class':
        Get.to(
          () => ClassView(
            teacherId: loginInfo.value?.id ?? '',
          ),
        );
        break;
      default:
        break;
    }
  }

  void switchLanguage() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('bottom_sheet.choose_language.title'.tr),
                trailing: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    'assets/svgs/icon_close.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Get.theme.hintColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(alpha: 0.1),
              ),
              Container(
                height: 132,
                padding: const EdgeInsets.only(bottom: 32),
                child: ListView.builder(
                  itemCount: languages.length,
                  itemExtent: 48,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(languages[index]['label'] ?? ''),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      trailing:
                          currentLanguage.value == languages[index]['value']
                              ? SvgPicture.asset(
                                  'assets/svgs/icon_checked.svg',
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                    Get.theme.primaryColor,
                                    BlendMode.srcIn,
                                  ),
                                )
                              : null,
                      onTap: () {
                        if (languages[index]['value'] != null) {
                          var locale = Locale(
                              languages[index]['value']!.split('_')[0],
                              languages[index]['value']!.split('_')[1]);
                          Get.updateLocale(locale);
                          currentLanguage.value = languages[index]['value']!;
                          localstorageService.setString(
                              LocalLanguageKey, languages[index]['value']!);
                          Get.back();
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
