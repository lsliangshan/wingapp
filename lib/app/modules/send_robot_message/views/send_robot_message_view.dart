import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/send_robot_message_controller.dart';

class SendRobotMessageView extends GetView<SendRobotMessageController> {
  final String robotCode;
  final String openConversationId;
  const SendRobotMessageView({
    super.key,
    required this.robotCode,
    required this.openConversationId,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SendRobotMessageView'),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: controller,
        builder: (_) {
          return ChatView(
            chatController: controller.chatController,
            chatViewState: ChatViewState.hasMessages,
          );
        },
      ),
    );
  }
}
