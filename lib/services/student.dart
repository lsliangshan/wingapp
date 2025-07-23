import 'dart:convert';
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wingapp/database/daos/teacher.dao.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/toast.dart';

class StudentService extends GetxService {
  EventBus eventBus = Get.find<EventBus>();
  TeacherDao teacherDao = Get.find<TeacherDao>();
  ToastService toastService = Get.find<ToastService>();

  Future<NormalResponse> getStudents({
    int pageIndex = 1,
    int pageSize = 20,
    String? classId,
    String? teacherId,
    String? status,
  }) async {
    String queryStr = 'pageIndex=$pageIndex&pageSize=$pageSize';
    if (classId != null && classId.isNotEmpty) {
      queryStr += '&classId=$classId';
    } else if (teacherId != null && teacherId.isNotEmpty) {
      queryStr += '&teacherId=$teacherId';
    }
    if (status != null && status.isNotEmpty) {
      queryStr += '&status=$status';
    }
    print('>>>>>>>>>>> queryStr: $queryStr');
    http.Response response = await http.get(
      Uri.parse('https://wf.liangqy.com/webhook/get-students?$queryStr'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.body.isEmpty) {
      return NormalResponse(
        code: 1001,
        message: '网络异常',
        data: {},
      );
    }

    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> getStudentsCount({
    required String classId,
    String? status,
  }) async {
    String queryStr = 'classId=$classId';
    if (status != null && status.isNotEmpty) {
      queryStr += '&status=$status';
    }
    http.Response response = await http.get(
      Uri.parse('https://wf.liangqy.com/webhook/get-students-count?$queryStr'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> getStudentDetail({
    required String id,
  }) async {
    http.Response response = await http.get(
      Uri.parse('https://wf.liangqy.com/webhook/get-student-detail?id=$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> updateStudentClass({
    required String id,
    required String classId,
    required String teacherId,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/update-student-class'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'classId': classId,
        'teacherId': teacherId,
      }),
    );
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }

  Future<NormalResponse> addStudent({
    required String id,
    required String openId,
    required String unionId,
    required String mobile,
    required String name,
    required String enName,
    required String birthday,
    required String gender,
    required String classId,
    required String teacherId,
    String? stateCode,
    String? avatar,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhooktest/add-student'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id,
        'unionId': unionId,
        'openId': openId,
        'name': name,
        'enName': enName,
        'stateCode': stateCode ?? '86',
        'mobile': mobile,
        'gender': gender,
        'classId': classId,
        'teacherId': teacherId,
        'birthday': birthday,
        'avatar': avatar ?? '',
      }),
    );
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }
}
