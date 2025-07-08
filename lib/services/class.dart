import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wingapp/database/daos/class.dao.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/toast.dart';

class ClassService extends GetxService {
  EventBus eventBus = Get.find<EventBus>();
  ClassDao classDao = Get.find<ClassDao>();
  ToastService toastService = Get.find<ToastService>();

  Future<NormalResponse> getClasses({
    int pageIndex = 1,
    int pageSize = 20,
    String? teacherId,
  }) async {
    http.Response response = await http.get(
      Uri.parse(
          'https://wf.liangqy.com/webhook-test/get-classes?pageIndex=$pageIndex&pageSize=$pageSize${teacherId != null ? '&teacherId=$teacherId' : ''}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> addClass({
    required String id,
    required String name,
    String? icon,
    String? teacherId,
    String? teacherName,
    String? teacherEnName,
    String? teacherUnionId,
    String? robotCode,
    String? openConversationId,
    String? link,
    String? assistant,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook-test/add-class'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'name': name,
        'icon': icon ?? '',
        'teacherId': teacherId ?? '',
        'teacherName': teacherName ?? '',
        'teacherEnName': teacherEnName ?? '',
        'teacherUnionId': teacherUnionId ?? '',
        'robotCode': robotCode ?? '',
        'openConversationId': openConversationId ?? '',
        'link': link ?? '',
        'assistant': assistant ?? '',
      }),
    );
    final data = json.decode(response.body);
    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> updateClass({
    required String id,
    String? name,
    String? icon,
    String? teacherId,
    String? teacherName,
    String? teacherEnName,
    String? teacherUnionId,
    String? robotCode,
    String? openConversationId,
    String? link,
    String? assistant,
  }) async {
    var params = <String, dynamic>{
      'id': id,
    };
    if (name != null) {
      params['name'] = name;
    }
    if (icon != null) {
      params['icon'] = icon;
    }
    if (teacherId != null) {
      params['teacherId'] = teacherId;
    }
    if (teacherName != null) {
      params['teacherName'] = teacherName;
    }
    if (teacherEnName != null) {
      params['teacherEnName'] = teacherEnName;
    }
    if (teacherUnionId != null) {
      params['teacherUnionId'] = teacherUnionId;
    }
    if (robotCode != null) {
      params['robotCode'] = robotCode;
    }
    if (openConversationId != null) {
      params['openConversationId'] = openConversationId;
    }
    if (link != null) {
      params['link'] = link;
    }
    if (assistant != null) {
      params['assistant'] = assistant;
    }

    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/update-class'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        ...params,
      }),
    );
    final data = json.decode(response.body);
    if (data['code'] == 200 && data['data'] != null) {
      await classDao.updateClass(
        id: id,
        name: name,
        icon: icon,
        teacherId: teacherId,
        teacherName: teacherName,
        teacherEnName: teacherEnName,
        teacherUnionId: teacherUnionId,
        robotCode: robotCode,
        openConversationId: openConversationId,
        link: link,
        assistant: assistant,
      );
    }
    return NormalResponse.fromJson(data);
  }
}
