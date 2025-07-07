import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wingapp/database/daos/teacher.dao.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/toast.dart';

class TeacherService extends GetxService {
  EventBus eventBus = Get.find<EventBus>();
  TeacherDao teacherDao = Get.find<TeacherDao>();
  ToastService toastService = Get.find<ToastService>();

  Future<NormalResponse> getSummayCounts() async {
    http.Response response = await http.get(
      Uri.parse('https://wf.liangqy.com/webhook/get-counts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> getTeachers({
    int pageIndex = 1,
    int pageSize = 20,
  }) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://wf.liangqy.com/webhook/get-teachers?pageIndex=$pageIndex&pageSize=$pageSize'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> loginWithDingtalk({
    required String id,
    required String unionId,
    required String openId,
    required String enName,
    required String stateCode,
    required String mobile,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/teacher-login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'unionId': unionId,
        'openId': openId,
        'enName': enName,
        'stateCode': stateCode,
        'mobile': mobile,
        'loginType': 'dingtalk',
      }),
    );
    final data = json.decode(response.body);
    if (data['code'] == 200 && data['data'] != null) {
      LoginInfo loginInfo = LoginInfo.fromJson(data['data']);
      await teacherDao.login(Teacher.fromJson(data['data']));
      eventBus.fire(LoginEvent(loginInfo));
    } else {}
    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> logout() async {
    LoginInfo? loginInfo = await teacherDao.getLoginInfo();
    await teacherDao.logout(loginInfo?.id ?? '');
    eventBus.fire(LogoutEvent());
    return NormalResponse.fromJson({'code': 200});
  }

  Future<NormalResponse> updateUser({
    String? mobile,
    String? email,
    String? avatar,
    String? name,
    String? enName,
    String? gender,
    String? type,
    String? status,
    String? unionId,
    String? openId,
  }) async {
    LoginInfo? loginInfo = await teacherDao.getLoginInfo();

    var params = <String, dynamic>{
      'id': loginInfo?.id ?? '',
      'token': loginInfo?.token ?? '',
    };
    if (unionId != null) {
      params['unionId'] = unionId;
    }
    if (openId != null) {
      params['openId'] = openId;
    }
    if (mobile != null) {
      params['mobile'] = mobile;
    }
    if (email != null) {
      params['email'] = email;
    }
    if (avatar != null) {
      params['avatar'] = avatar;
    }
    if (enName != null) {
      params['enName'] = enName;
    }
    if (name != null) {
      params['name'] = name;
    }
    if (gender != null) {
      params['gender'] = gender;
    }
    if (type != null) {
      params['type'] = type;
    }
    if (status != null) {
      params['status'] = status;
    }

    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/teacher-update'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        ...params,
      }),
    );
    final data = json.decode(response.body);
    if (data['code'] == 200 && data['data'] != null) {
      await teacherDao.updateUser(
        id: loginInfo?.id ?? '',
        unionId: unionId,
        openId: openId,
        mobile: mobile,
        email: email,
        avatar: avatar,
        enName: enName,
        name: name,
        gender: gender,
        type: type,
        status: status,
      );
    }
    return NormalResponse.fromJson(data);
  }

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
