import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:markdown_widget/config/configs.dart';
import 'package:markdown_widget/widget/blocks/leaf/paragraph.dart';

import 'package:markdown_widget/widget/markdown_block.dart';

class MessageBubbleView extends GetView {
  final String message;
  final bool isSender;
  const MessageBubbleView({
    super.key,
    required this.message,
    required this.isSender,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: Get.width - 64 - 16 - 16,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 4,
      ),
      margin: EdgeInsets.only(
        bottom: 12,
        top: 12,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isSender ? Color(0xFF07c160) : Get.theme.colorScheme.surface,
      ),
      // isSender: message.senderId == controller.loginInfo.value?.id,

      // tail: false,
      // textStyle: TextStyle(
      //   fontSize: 15,
      //   color: (message.senderId == controller.loginInfo.value?.id)
      //       ? Get.theme.colorScheme.onPrimary
      //       : Get.theme.colorScheme.onSurface,
      //   // fontWeight: FontWeight.w500,
      // ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: MarkdownBlock(
          data: message,
          config: MarkdownConfig(
            configs: [
              PConfig(
                textStyle: TextStyle(
                  fontSize: 15,
                  color: isSender
                      ? Get.theme.colorScheme.onPrimary
                      : Get.theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
