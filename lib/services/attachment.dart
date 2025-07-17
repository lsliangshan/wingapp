import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
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

  Future<NormalResponse> uploadAttachment({
    required String content,
    required String filename,
    required String classId,
    required String className,
    required String uploaderId,
    required String uploaderName,
  }) async {
    File? file;

    // 1. 获取临时目录
    final directory = await getTemporaryDirectory();
    final filePath = path.join(directory.path, filename);

    // 2. 写入文件
    file = File(filePath);
    await file.writeAsString(content);

    // 3. 构建 Multipart 请求
    final uri = Uri.parse(
        'https://wf.liangqy.com/webhook-test/add-attachments'); // 替换成你的实际 URL
    final request = http.MultipartRequest('POST', uri)
      ..fields['classId'] = classId
      ..fields['className'] = Uri.encodeComponent(className)
      ..fields['uploaderName'] = Uri.encodeComponent(uploaderName)
      ..fields['uploaderId'] = uploaderId;

    final bytes = utf8.encode(content);
    final multipartFile = http.MultipartFile.fromBytes(
      'files', // 字段名
      bytes, // 内容
      filename: '$filename.txt',
      contentType: MediaType('text', 'plain'),
    );

    request.files.add(multipartFile);

    // 4. 发送请求
    final response = await request.send();

    final data = json.decode(await response.stream.bytesToString());

    if (await file.exists()) {
      try {
        await file.delete();
      } catch (_) {}
    }

    // 5. 响应处理
    return NormalResponse.fromJson(data);

    // final data = json.decode(response.data);
    // print('>>>>>>> data: $data');
    // return NormalResponse.fromJson(data);
  }
}
