import 'dart:convert';

import 'package:event_bus/event_bus.dart';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:get/get.dart';
import 'package:wingapp/database/daos/message.dao.dart';

import 'package:wingapp/database/database.dart';

class MessageService extends GetxService {
  EventBus eventBus = Get.find<EventBus>();
  MessageDao messageDao = Get.find<MessageDao>();

  Future<List<Message>> getMessages({
    required String classId,
    int? pageIndex = 1,
    int? pageSize = 20,
  }) async {
    List<Message> messages = await messageDao.getMessages(
        classId: classId, pageIndex: pageIndex, pageSize: pageSize);
    return messages;
  }

  Future<void> sendMessage({
    required String id,
    required String classId,
    required String content,
    required String senderId,
    required String senderName,
    String? senderAvatar,
    String? type,
    bool? isRobot,
    String? from,
  }) async {
    await messageDao.createMessage(
      id: id,
      classId: classId,
      content: content,
      senderId: senderId,
      senderName: senderName,
      senderAvatar: senderAvatar,
      type: type,
      isRobot: isRobot,
      from: from,
    );
  }

  Future<void> initMessageService() async {
    final subscription = SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: 'http://frp.liangqy.com/on/all/wing/robot/message',
      header: {
        'Accept': 'text/event-stream',
        "Cache-Control": "no-cache",
      },
    ).listen((event) {
      if (event.data != null && event.data!.isNotEmpty) {
        Message data = Message.fromJson(jsonDecode(event.data!));
        sendMessage(
          id: data.id,
          classId: data.classId,
          content: data.content,
          senderId: data.senderId,
          senderName: data.senderName,
          senderAvatar: data.senderAvatar,
          type: data.type,
          isRobot: data.isRobot,
          from: data.from,
        );
      }
    });
  }
}
