import 'package:wingapp/types/types.dart';

class MessageEntity {
  String message;
  String senderId;
  String senderName;
  String? senderAvatar;
  MessageType? messageType;
  String? time;

  MessageEntity({
    required this.message,
    required this.senderId,
    required this.senderName,
    this.senderAvatar,
    this.messageType,
    this.time,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      message: json['message'] ?? '',
      senderId: json['senderId'] ?? '',
      senderName: json['senderName'] ?? '',
      senderAvatar: json['senderAvatar'],
      messageType: json['messageType'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['senderId'] = senderId;
    data['senderName'] = senderName;
    data['senderAvatar'] = senderAvatar;
    data['messageType'] = messageType;
    data['time'] = time;
    return data;
  }
}
