// import 'dart:convert';

// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
// import 'package:event_bus/event_bus.dart';
// import 'package:get/get.dart';
// import 'package:giftify/database/daos/user.dao.dart';
// import 'package:giftify/events/events.dart';
// import 'package:giftify/models/login_info.model.dart';
// import 'package:giftify/models/normal_response.model.dart';
// import 'package:giftify/services/toast.dart';
// import 'package:http/http.dart' as http;

// class UserService extends GetxService {
//   EventBus eventBus = Get.find<EventBus>();
//   UserDao userDao = Get.find<UserDao>();
//   ToastService toastService = Get.find<ToastService>();

//   Future<NormalResponse> login({
//     required String username,
//     required String password,
//   }) async {
//     http.Response response = await http.post(
//       Uri.parse('https://api.liangqy.com/giftify/user/login'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'username': username,
//         'password': password,
//       }),
//     );
//     final data = json.decode(response.body);
//     if (data['code'] == 200 && data['data'] != null) {
//       LoginInfo loginInfo = LoginInfo.fromJson(data['data']);
//       await userDao.login(loginInfo);
//       eventBus.fire(LoginEvent(loginInfo));
//       // toastService.showMessage(
//       //   message: 'login.status.success'.tr,
//       // );
//     } else {
//       // toastService.showMessage(
//       //   message: 'login.status.fail'.tr,
//       // );
//     }
//     return NormalResponse.fromJson(data);
//   }

//   Future<NormalResponse> logout() async {
//     LoginInfo? loginInfo = await userDao.getLoginInfo();
//     await userDao.logout(loginInfo?.id ?? 0);
//     eventBus.fire(LogoutEvent());
//     return NormalResponse.fromJson({'code': 200});
//   }

//   Future<NormalResponse> register({
//     required String username,
//     required String password,
//   }) async {
//     http.Response response = await http.post(
//       Uri.parse('https://api.liangqy.com/giftify/user/register'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'username': username,
//         'password': password,
//       }),
//     );
//     final data = json.decode(response.body);

//     return NormalResponse.fromJson(data);
//   }

//   Future<NormalResponse> reloadLoginInfo() async {
//     LoginInfo? loginInfo = await userDao.getLoginInfo();
//     http.Response response = await http.post(
//       Uri.parse('https://api.liangqy.com/giftify/user/reload-info'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'userId': loginInfo?.id.toString() ?? '',
//         'token': loginInfo?.token ?? '',
//       }),
//     );
//     final data = json.decode(response.body);
//     if (data['code'] == 200 && data['data'] != null) {
//       LoginInfo newLoginInfo = LoginInfo.fromJson(data['data']);
//       await userDao.reloadLoginInfo(newLoginInfo);
//     }
//     return NormalResponse.fromJson(data);
//   }

//   Future<NormalResponse> updateUser({
//     String? phonenum,
//     String? email,
//     String? headIcon,
//     String? nickname,
//     int? gender,
//   }) async {
//     LoginInfo? loginInfo = await userDao.getLoginInfo();

//     var params = <String, dynamic>{
//       'userId': loginInfo?.id.toString() ?? '',
//       'token': loginInfo?.token ?? '',
//     };
//     if (phonenum != null) {
//       params['phonenum'] = phonenum;
//     }
//     if (email != null) {
//       params['email'] = email;
//     }
//     if (headIcon != null) {
//       params['headIcon'] = headIcon;
//     }
//     if (nickname != null) {
//       params['nickname'] = nickname;
//     }
//     if (gender != null) {
//       params['gender'] = gender;
//     }

//     http.Response response = await http.post(
//       Uri.parse('https://api.liangqy.com/giftify/user/update'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         ...params,
//       }),
//     );
//     final data = json.decode(response.body);
//     if (data['code'] == 200 && data['data'] != null) {
//       await userDao.updateUser(
//         id: loginInfo?.id ?? 0,
//         phonenum: phonenum,
//         email: email,
//         headIcon: headIcon,
//         nickname: nickname,
//         gender: gender,
//       );
//     }
//     return NormalResponse.fromJson(data);
//   }

//   Future<NormalResponse> deleteUser() async {
//     LoginInfo? loginInfo = await userDao.getLoginInfo();
//     http.Response response = await http.post(
//       Uri.parse('https://api.liangqy.com/giftify/user/delete'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'userId': loginInfo?.id.toString() ?? '',
//         'token': loginInfo?.token ?? '',
//       }),
//     );
//     final data = json.decode(response.body);

//     if (data['code'] == 200) {
//       await userDao.logout(loginInfo?.id ?? 0);
//       eventBus.fire(LogoutEvent());

//       // toastService.showSuccess(
//       //   message: 'settings.delete.account.success.title'.tr,
//       // );
//     } else {
//       // toastService.showMessage(
//       //   message: 'settings.delete.account.failed.title'.tr,
//       // );
//     }
//     return NormalResponse.fromJson(data);
//   }

//   Future<LoginInfo?> getLoginInfo() async {
//     LoginInfo? loginInfo = await userDao.getLoginInfo();
//     bool needReload = false;
//     if (loginInfo != null) {
//       if (isExpired(
//         username: loginInfo.username!,
//         token: loginInfo.token ?? '',
//       )) {
//         // TOKEN 过期
//         needReload = true;
//       }
//     } else {
//       needReload = false;
//     }
//     if (needReload) {
//       await reloadLoginInfo();
//       loginInfo = await userDao.getLoginInfo();
//     }
//     return loginInfo;
//   }

//   Future<bool> isLoggedIn() async {
//     LoginInfo? loginInfo = await getLoginInfo();
//     if (loginInfo == null) {
//       return false;
//     }
//     return true;
//   }

//   bool isExpired({
//     required String username,
//     required String token,
//   }) {
//     bool expired = false;
//     try {
//       final jwt = JWT.verify(
//         token,
//         SecretKey('dei2.com'),
//       );
//       int exp = jwt.payload['exp'] as int;
//       if ((exp * 1000 >
//               DateTime.now().millisecondsSinceEpoch - 10 * 60 * 1000) ||
//           jwt.payload['data'] == null ||
//           jwt.payload['data']['username'] == username) {
//         expired = true;
//       } else {
//         expired = false;
//       }
//     } on JWTExpiredException {
//       expired = true;
//     } on JWTException catch (_) {
//       expired = true;
//     }
//     return expired;
//   }

//   Future<NormalResponse> exchangeActivationCode({
//     required String code,
//   }) async {
//     LoginInfo? loginInfo = await userDao.getLoginInfo();
//     http.Response response = await http.post(
//       Uri.parse('https://api.liangqy.com/giftify/activation-code/use'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'userId': loginInfo?.id.toString() ?? '',
//         'token': loginInfo?.token ?? '',
//         'code': code,
//       }),
//     );
//     final data = json.decode(response.body);
//     return NormalResponse.fromJson(data);
//   }
// }
