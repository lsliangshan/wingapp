import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:wingapp/database/daos/teacher.dao.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/http.dart';
import 'package:wingapp/services/toast.dart';

class DingtalkService extends GetxService {
  EventBus eventBus = Get.find<EventBus>();
  TeacherDao teacherDao = Get.find<TeacherDao>();
  ToastService toastService = Get.find<ToastService>();

  Future<NormalResponse> getUserInfoByAuthCode({
    required String authCode,
  }) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://wf.liangqy.com/webhook/getDingtalkUserInfoByAuthCode?code=$authCode'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = json.decode(response.body);
    print('>>>>>>>> getUserInfoByAuthCode: ${data}');
    if (data['code'] == 200 && data['data'] != null) {
      return NormalResponse.fromJson(data);
    } else {
      return NormalResponse.fromJson(data);
    }
  }

  Future<NormalResponse> uploadFile({
    required XFile file,
  }) async {
    NormalResponse response = await post(
      'https://wf.liangqy.com/webhook/upload',
      data: {
        'type': 'image',
        'media': file,
      },
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    );
    print('>>>>>>>> uploadFile: ${response.data}');
    return response;
  }
}
