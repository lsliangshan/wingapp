import 'package:chatview/chatview.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/services/user.dart';

class SendRobotMessageController extends GetxController {
  final EventBus eventBus = Get.find<EventBus>();
  final UserService userService = Get.find<UserService>();

  late ChatController chatController;

  RxList<Message> messages = <Message>[].obs;

  Rx<LoginInfo?> loginInfo = Rx<LoginInfo?>(null);

  RxString robotCode = ''.obs;
  RxString openConversationId = ''.obs;

  late Future<void> initDataFuture;

  @override
  void onInit() {
    super.onInit();

    eventBus.on<LoginEvent>().listen((event) {
      loginInfo.value = event.loginInfo;
    });

    eventBus.on<LogoutEvent>().listen((event) {
      loginInfo.value = null;
    });

    robotCode.value = Get.arguments['robotCode'] ?? '';
    openConversationId.value = Get.arguments['openConversationId'] ?? '';

    initDataFuture = initData();
  }

  Future<void> initData() async {
    await initLoginInfo();

    chatController = ChatController(
      initialMessageList: [],
      scrollController: ScrollController(),
      otherUsers: [],
      currentUser: ChatUser(
        id: loginInfo.value?.id ?? '',
        name: loginInfo.value?.name ?? '',
        profilePhoto: loginInfo.value?.avatar ??
            'https://img.liangqy.com/wingapp/logo.png',
      ),
    );
  }

  Future<void> initLoginInfo() async {
    loginInfo.value = await userService.getLoginInfo();
  }

  void onSendTap(
    String message,
    ReplyMessage replyMessage,
    MessageType messageType,
  ) {
    final newMessage = Message(
      id: Uuid().v4(),
      message: message,
      createdAt: DateTime.now(),
      sentBy: loginInfo.value?.id ?? '',
      messageType: messageType,
      replyMessage: replyMessage,
    );

    chatController.addMessage(newMessage);
  }
}
