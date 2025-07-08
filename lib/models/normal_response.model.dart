class NormalResponse {
  int code;
  String? message;
  int? contentLength;
  Map<String, dynamic> headers;
  dynamic data;

  // 构造函数
  NormalResponse({
    required this.code,
    this.message,
    this.contentLength,
    this.headers = const {},
    this.data = const {},
  });

  // 从 JSON 转换为 Model
  factory NormalResponse.fromJson(Map<String, dynamic> json) {
    return NormalResponse(
      code: int.parse('${json['code']}'),
      message: json['message'],
      contentLength: json['contentLength'],
      headers: json['headers'] ?? {},
      data: json['data'] ?? {},
    );
  }

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'contentLength': contentLength,
      'headers': headers,
      'data': data,
    };
  }
}
