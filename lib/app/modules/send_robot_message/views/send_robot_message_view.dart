import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/modules/send_robot_message/views/message_bubble_view.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/components/need_login/need_login.dart';
import 'package:wingapp/database/database.dart';

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
      width: 32,
      height: 32,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Get.theme.colorScheme.surface,
      ),
      child: CachedNetworkImage(
        imageUrl: avatar,
        placeholder: (context, url) => Container(
          width: 32,
          height: 32,
          color: Get.theme.colorScheme.surface,
          child: const Icon(Icons.error),
        ),
        errorWidget: (context, url, error) => Container(
          width: 32,
          height: 32,
          color: Get.theme.colorScheme.surface,
          child: const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildMessageItemData(Message message, int index) {
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
                    textDirection:
                        (message.senderId != controller.loginInfo.value?.id)
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                    children: [
                      if (message.isRobot != null && message.isRobot == true)
                        Container(
                          width: 14,
                          height: 14,
                          margin: EdgeInsets.only(
                            top: 2,
                            right: 8,
                          ),
                          child: Icon(
                            Icons.smart_toy,
                            size: 14,
                            color: Get.theme.hintColor,
                          ),
                        ),
                      if (message.isRobot != null &&
                          message.isRobot == false &&
                          message.from == 'dingtalk')
                        Container(
                          width: 14,
                          height: 14,
                          margin: EdgeInsets.only(
                            top: 2,
                            left: (message.senderId !=
                                    controller.loginInfo.value?.id)
                                ? 0
                                : 8,
                            right: (message.senderId !=
                                    controller.loginInfo.value?.id)
                                ? 8
                                : 0,
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://img.liangqy.com/wingapp/dingtalk.png',
                            width: 14,
                            height: 14,
                            fit: BoxFit.cover,
                          ),
                        ),
                      Text(
                        message.senderName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        message.createAt ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // BubbleNormal(
                //   constraints: BoxConstraints(
                //     maxWidth: Get.width - 64 - 16,
                //   ),
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 12,
                //     vertical: 12,
                //   ),
                //   text: message.content,
                //   isSender: message.senderId == controller.loginInfo.value?.id,
                //   color: (message.senderId == controller.loginInfo.value?.id)
                //       ? Color(0xFF07c160)
                //       : Get.theme.colorScheme.surface,
                //   tail: false,
                //   textStyle: TextStyle(
                //     fontSize: 15,
                //     color: (message.senderId == controller.loginInfo.value?.id)
                //         ? Get.theme.colorScheme.onPrimary
                //         : Get.theme.colorScheme.onSurface,
                //     // fontWeight: FontWeight.w500,
                //   ),
                // ),
                Row(
                  mainAxisAlignment:
                      message.senderId == controller.loginInfo.value?.id
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                  children: [
                    if (message.senderId != controller.loginInfo.value?.id)
                      SizedBox(width: 16),
                    MessageBubbleView(
                      message: message.content,
                      isSender:
                          message.senderId == controller.loginInfo.value?.id,
                    ),
                    if (message.senderId == controller.loginInfo.value?.id)
                      SizedBox(width: 16),
                  ],
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

  Widget _buildMessageItem(Message message, int index) {
    return Column(
      children: [
        if (index == 0 &&
            controller.pageIndex.value != controller.totalPage.value)
          Container(
            // height: 16,
            margin: EdgeInsets.only(
              top: 16,
              bottom: 16,
            ),
            child: Container(
              // height: 20,
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Get.theme.hintColor.withValues(
                  alpha: 0.06,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'send_robot_message.load_more_message'.tr,
                style: TextStyle(
                  fontSize: 12,
                  color: Get.theme.hintColor,
                ),
              ),
            ),
          ),
        _buildMessageItemData(message, index),
      ],
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
                      physics: const AlwaysScrollableScrollPhysics(),
                      slivers: [
                        SliverList.builder(
                          itemBuilder: (context, index) {
                            return _buildMessageItem(
                              controller.messages[index],
                              index,
                            );
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
