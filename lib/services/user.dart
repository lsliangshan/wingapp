import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';

import 'package:wingapp/database/daos/teacher.dao.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/services/toast.dart';

class UserService extends GetxService {
  EventBus eventBus = Get.find<EventBus>();
  TeacherDao teacherDao = Get.find<TeacherDao>();
  ToastService toastService = Get.find<ToastService>();

  Future<LoginInfo?> getLoginInfo() async {
    LoginInfo? loginInfo = await teacherDao.getLoginInfo();
    bool needReload = false;
    if (loginInfo != null) {
      if (isExpired(
        id: loginInfo.id!,
        token: loginInfo.token ?? '',
        unionId: loginInfo.unionId ?? '',
        openId: loginInfo.openId ?? '',
        mobile: loginInfo.mobile ?? '',
      )) {
        // TOKEN 过期
        needReload = true;
      }
    } else {
      needReload = false;
    }
    if (needReload) {
      loginInfo = await teacherDao.getLoginInfo();
    }
    return loginInfo;
  }

  Future<bool> isLoggedIn() async {
    LoginInfo? loginInfo = await getLoginInfo();
    if (loginInfo == null) {
      return false;
    }
    return true;
  }

  bool isExpired({
    required String id,
    required String unionId,
    required String openId,
    required String mobile,
    required String token,
  }) {
    bool expired = false;
    try {
      final jwt = JWT.verify(
        token,
        SecretKey('liangqy.com'),
      );
      int exp = jwt.payload['exp'] as int;
      if ((exp * 1000 >
              DateTime.now().millisecondsSinceEpoch - 10 * 60 * 1000) ||
          jwt.payload['data'] == null ||
          jwt.payload['data']['id'] == id) {
        expired = true;
      } else {
        expired = false;
      }
    } on JWTExpiredException {
      expired = true;
    } on JWTException catch (_) {
      expired = true;
    }
    return expired;
  }
}
