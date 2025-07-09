import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/components/need_login/need_login.dart';

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
        title: Text(
          'send_robot_message.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: const CustomBackwardView(),
      ),
      body: FutureBuilder(
        future: controller.initDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CustomLoader(),
            );
          }

          if (controller.loginInfo.value?.id == null) {
            return Center(
              child: NeedLogin(),
            );
          }

          return GetBuilder(
            init: controller,
            builder: (_) {
              return ChatView(
                chatController: controller.chatController,
                onSendTap: controller.onSendTap,
                chatViewState: ChatViewState.hasMessages,
              );
            },
          );
        },
      ),
    );
  }
}
