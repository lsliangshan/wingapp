import 'dart:convert';
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wingapp/database/daos/teacher.dao.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/toast.dart';

class ScheduleService extends GetxService {
  EventBus eventBus = Get.find<EventBus>();
  TeacherDao teacherDao = Get.find<TeacherDao>();
  ToastService toastService = Get.find<ToastService>();

  Future<NormalResponse> getSchedules({
    int pageIndex = 1,
    int pageSize = 20,
    String? classId,
    String? teacherId,
    String? date,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/get-schedules'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'pageIndex': '$pageIndex',
        'pageSize': '$pageSize',
        'classId': classId ?? '',
        'teacherId': teacherId ?? '',
        'date': date ?? '',
      }),
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

  Future<NormalResponse> getScheduleDetailByFormId({
    required String formId,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/get-schedule-by-formId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'formId': formId,
      }),
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

  Future<NormalResponse> addSchedules({
    required String formId,
    required String classId,
    required String className,
    required String teacherUnionId,
    required String title,
    required String content,
    required List<dynamic> schedule,
    required List<dynamic> reminders,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook-test/add-schedules'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'formId': formId,
        'classId': classId,
        'className': className,
        'teacherUnionId': teacherUnionId,
        'title': title,
        'content': content,
        'schedule': schedule,
        'reminders': reminders,
      }),
    );

    print('>>>>>>>>>>>>>>>>>>>>addSchedules: ${response.body}');

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

  Future<NormalResponse> getScheduleCountsMonthly({
    required String date,
  }) async {
    http.Response response = await http.post(
      Uri.parse('https://wf.liangqy.com/webhook/get-month-schedule-counts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'date': date,
      }),
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
}
