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
    String? status,
  }) async {
    String queryStr = 'pageIndex=$pageIndex&pageSize=$pageSize';
    if (classId != null && classId.isNotEmpty) {
      queryStr += '&classId=$classId';
    }
    if (status != null && status.isNotEmpty) {
      queryStr += '&status=$status';
    }
    http.Response response = await http.get(
      Uri.parse('https://wf.liangqy.com/webhook/get-students?$queryStr'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
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
}
