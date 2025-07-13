import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/components/need_login/need_login.dart';
import 'package:wingapp/models/message_entity.dart';
import 'package:chat_bubbles/chat_bubbles.dart';

import '../controllers/send_robot_message_controller.dart';

class SendRobotMessageView extends GetView<SendRobotMessageController> {
  final String robotCode;
  final String openConversationId;
  final String classId;

  const SendRobotMessageView({
    super.key,
    required this.robotCode,
    required this.openConversationId,
    required this.classId,
  });

  Widget _buildAvatar(String avatar) {
    return Container(
      width: 48,
      height: 48,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: CachedNetworkImage(
        imageUrl: avatar,
        placeholder: (context, url) => Container(
          width: 48,
          height: 48,
          color: Get.theme.colorScheme.surface,
          child: const Icon(Icons.error),
        ),
        errorWidget: (context, url, error) => Container(
          width: 48,
          height: 48,
          color: Get.theme.colorScheme.surface,
          child: const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildMessageItem(MessageEntity message) {
    return Container(
      margin: EdgeInsets.only(
        top: 16,
        bottom: 16,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 0,
        children: [
          if (message.senderId != controller.loginInfo.value?.id)
            _buildAvatar(message.senderAvatar ?? ''),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 18,
                  margin: EdgeInsets.only(
                    left: 16,
                    right: 16,
                  ),
                  alignment:
                      (message.senderId != controller.loginInfo.value?.id)
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                  child: Row(
                    spacing: 16,
                    textDirection:
                        (message.senderId != controller.loginInfo.value?.id)
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    children: [
                      Text(
                        message.senderName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        message.time ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                BubbleNormal(
                  constraints: BoxConstraints(
                    maxWidth: Get.width - 64 - 16,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  text: message.message,
                  isSender: message.senderId == controller.loginInfo.value?.id,
                  color: (message.senderId == controller.loginInfo.value?.id)
                      ? Get.theme.colorScheme.primary
                      : Get.theme.colorScheme.surface,
                  tail: false,
                  textStyle: TextStyle(
                    fontSize: 15,
                    color: (message.senderId == controller.loginInfo.value?.id)
                        ? Get.theme.colorScheme.onPrimary
                        : Get.theme.colorScheme.onSurface,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (message.senderId == controller.loginInfo.value?.id)
            _buildAvatar(message.senderAvatar ?? ''),
        ],
      ),
    );
  }

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
            id: 'update-messages',
            init: controller,
            builder: (_) {
              return Column(
                children: [
                  Expanded(
                    child: CustomScrollView(
                      controller: controller.scrollController,
                      slivers: [
                        SliverList.builder(
                          itemBuilder: (context, index) {
                            return _buildMessageItem(
                                controller.messages[index]);
                          },
                          itemCount: controller.messages.length,
                        ),
                      ],
                    ),
                  ),
                  SafeArea(
                    child: Container(
                      // height: 64,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          // left: 16,
                          // right: 8,
                          ),
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 16,
                        right: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Get.theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        spacing: 8,
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller.messageController,
                              focusNode: controller.messageFocusNode,
                              maxLines: 6,
                              minLines: 1,
                              onTapOutside: (event) {
                                controller.messageFocusNode.unfocus();
                              },
                              decoration: InputDecoration(
                                hintText: 'send_robot_message.hint_text'.tr,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                filled: true,
                                fillColor: Get.theme.hintColor.withValues(
                                  alpha: 0.06,
                                ),
                                contentPadding: const EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  top: 12,
                                  bottom: 12,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 48,
                            height: 48,
                            child: IconButton(
                              onPressed: () {
                                controller.sendMessage();
                              },
                              icon: const Icon(Icons.send),
                              visualDensity: VisualDensity.compact,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
