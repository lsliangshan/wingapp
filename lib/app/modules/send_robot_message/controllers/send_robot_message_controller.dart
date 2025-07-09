import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SendRobotMessageController extends GetxController {
  ChatController chatController = ChatController(
    initialMessageList: [],
    scrollController: ScrollController(),
    otherUsers: [],
    currentUser: ChatUser(
      id: '1',
      name: 'Wingapp',
    ),
  );

  RxList<Message> messages = <Message>[].obs;

  RxString robotCode = ''.obs;
  RxString openConversationId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    robotCode.value = Get.arguments['robotCode'] ?? '';
    openConversationId.value = Get.arguments['openConversationId'] ?? '';
  }
}
