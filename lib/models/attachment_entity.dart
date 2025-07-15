class AttachmentEntity {
  String id;
  String filename;
  String url;
  String classId;
  String? className;
  String? uploaderId;
  String? createAt;
  String? updateAt;

  AttachmentEntity({
    required this.id,
    required this.filename,
    required this.url,
    required this.classId,
    this.className,
    this.uploaderId,
    this.createAt,
    this.updateAt,
  });

  factory AttachmentEntity.fromJson(Map<String, dynamic> json) {
    return AttachmentEntity(
      id: json['id'] ?? '',
      filename: json['filename'] ?? '',
      url: json['url'] ?? '',
      classId: json['classId'] ?? '',
      className: json['className'],
      uploaderId: json['uploaderId'],
      createAt: json['createAt'],
      updateAt: json['updateAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['filename'] = filename;
    data['url'] = url;
    data['classId'] = classId;
    data['className'] = className;
    data['uploaderId'] = uploaderId;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    return data;
  }
}
