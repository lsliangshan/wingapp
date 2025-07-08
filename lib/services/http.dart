import 'dart:convert';

import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

String jsonToUrlParams(Map<String, dynamic> json) {
  return json.entries
      .map((entry) =>
          '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value.toString())}')
      .join('&');
}

Future<NormalResponse> get(
  String url, {
  Map<String, dynamic>? headers = const {},
  Map<String, dynamic>? data = const {},
}) async {
  try {
    http.Response response = await http.get(
      Uri.parse(
          '$url${url.contains("?") ? "&" : "?"}${jsonToUrlParams(data!)}'),
      headers: headers!.map((key, value) => MapEntry(key, value.toString())),
    );

    final jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      return NormalResponse(
        code: 200,
        message: "请求成功",
        headers: response.headers,
        contentLength: response.contentLength,
        data: jsonData,
      );
    }
    return NormalResponse(
      code: response.statusCode,
      message: response.reasonPhrase ?? "请求失败",
      contentLength: response.contentLength,
      headers: response.headers,
      data: jsonData,
    );
  } catch (e) {
    if (e.toString().contains('timed out')) {
      return NormalResponse(
        code: 599,
        message: "请求超时",
        contentLength: 0,
        headers: {},
        data: {},
      );
    }
    return NormalResponse(
      code: 500,
      message: "请求失败",
      contentLength: 0,
      headers: {},
      data: {},
    );
  }
}

Future<NormalResponse> handleFileUpload(
  String url, {
  Map<String, dynamic>? headers = const {},
  Map<String, dynamic>? data = const {},
}) async {
  http.MultipartRequest request = http.MultipartRequest(
    'POST',
    Uri.parse(url),
  );

  bool hasFile = false;

  for (var entry in data!.entries) {
    if (entry.value.runtimeType == XFile) {
      hasFile = true;
      request.files.add(
        await http.MultipartFile.fromPath(
            entry.key, (entry.value as XFile).path),
      );
    } else {
      request.fields[entry.key] = entry.value;
    }
  }

  request.headers
      .addAll(headers!.map((key, value) => MapEntry(key, value.toString())));

  if (hasFile) {
    http.StreamedResponse response = await request.send();
    final jsonData = json.decode(await response.stream.bytesToString());
    if (response.statusCode == 200) {
      return NormalResponse(
        code: 200,
        message: "请求成功",
        headers: response.headers,
        contentLength: response.contentLength,
        data: jsonData,
      );
    }
    return NormalResponse(
      code: response.statusCode,
      message: response.reasonPhrase ?? "请求失败",
      contentLength: response.contentLength,
      headers: response.headers,
      data: jsonData,
    );
  }

  return NormalResponse(
    code: 1001,
    message: "文件不存在",
    contentLength: 0,
    headers: {},
    data: {},
  );
}

Future<NormalResponse> post(
  String url, {
  Map<String, dynamic>? headers = const {},
  Map<String, dynamic>? data = const {},
}) async {
  try {
    if (headers != null &&
        headers.containsKey('Content-Type') &&
        headers['Content-Type'] == 'multipart/form-data') {
      // 处理文件上传
      // final multipartClient = new http.MultipartRequest(method, url)
      return handleFileUpload(url, headers: headers, data: data);
    }

    http.Response response = await http.post(
      Uri.parse(url),
      headers: headers!.map((key, value) => MapEntry(key, value.toString())),
      body: jsonEncode(data),
    );

    final jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      return NormalResponse(
        code: 200,
        message: "请求成功",
        headers: response.headers,
        contentLength: response.contentLength,
        data: jsonData,
      );
    }
    return NormalResponse(
      code: response.statusCode,
      message: response.reasonPhrase ?? "请求失败",
      contentLength: response.contentLength,
      headers: response.headers,
      data: jsonData,
    );
  } catch (e) {
    if (e.toString().contains('timed out')) {
      return NormalResponse(
        code: 599,
        message: "请求超时",
        contentLength: 0,
        headers: {},
        data: {},
      );
    }

    return NormalResponse(
      code: 500,
      message: "请求失败",
      contentLength: 0,
      headers: {},
      data: {},
    );
  }
}

class HttpService extends GetxService {
  Future<NormalResponse> uploadImage(XFile image) async {
    return await post(
      'https://api.liangqy.com/upload/image',
      data: {
        'file': image,
      },
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    );
  }
}
