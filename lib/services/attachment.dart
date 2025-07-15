import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:wingapp/models/normal_response.model.dart';

class AttachmentService extends GetxService {
  Future<NormalResponse> getAttachments({
    String? classId,
  }) async {
    String queryStr = '';
    if (classId != null && classId.isNotEmpty) {
      queryStr += 'classId=$classId';
    }
    http.Response response = await http.get(
      Uri.parse('https://wf.liangqy.com/webhook/get-attachments?$queryStr'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    final data = json.decode(response.body);

    return NormalResponse.fromJson(data);
  }
}
