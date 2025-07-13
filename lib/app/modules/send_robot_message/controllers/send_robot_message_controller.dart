import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/models/message_entity.dart';
import 'package:wingapp/services/dingtalk.dart';
import 'package:wingapp/services/user.dart';
import 'package:wingapp/types/types.dart';

class SendRobotMessageController extends GetxController {
  final EventBus eventBus = Get.find<EventBus>();
  final UserService userService = Get.find<UserService>();
  final DingtalkService dingtalkService = Get.find<DingtalkService>();

  final ScrollController scrollController = ScrollController();

  final TextEditingController messageController = TextEditingController();

  final FocusNode messageFocusNode = FocusNode();

  String prevText = '';

  Rx<LoginInfo?> loginInfo = Rx<LoginInfo?>(null);

  RxList<LoginInfo> atUsers = <LoginInfo>[].obs;

  RxString robotCode = ''.obs;
  RxString openConversationId = ''.obs;
  RxString classId = ''.obs;

  RxList<MessageEntity> messages = <MessageEntity>[
    MessageEntity(
      message: '以下是一些 Flutter 第三方聊天气泡组件的推荐，适合快速集成漂亮的聊天界面，也支持自定义和扩展：',
      senderId: '031522673572377571',
      senderName: 'John Doe',
      time: '2025-01-01 12:00:00',
      senderAvatar:
          'https://img1.baidu.com/it/u=2269292895,825961646&fm=253&fmt=auto&app=120&f=JPEG?w=800&h=800',
      messageType: MessageType.text,
    ),
    MessageEntity(
      message:
          'I am fine, thank you!Hello, how are you?Hello, how are you?Hello, how are you?Hello, how are you?Hello, how are you?Hello, how are you?Hello, how are you?Hello, how are you?',
      senderId: '456',
      senderName: 'Jane Smith',
      time: '2025-01-01 12:00:00',
      senderAvatar:
          'https://wx3.sinaimg.cn/mw690/a1ac48b7ly1hthawuktxwj20m80m87fs.jpg',
      messageType: MessageType.text,
    ),
  ].obs;

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

    prevText = messageController.text;

    robotCode.value = Get.arguments['robotCode'] ?? '';
    openConversationId.value = Get.arguments['openConversationId'] ?? '';
    classId.value = Get.arguments['classId'] ?? '';

    initDataFuture = initData();

    messageController.addListener(messageListener);
  }

  void removeAtUser(String atUser) {
    atUsers.removeWhere((element) => element.name == atUser);
    update(['update-at-users']);
  }

  void messageListener() {
    final curr = messageController.text;
    if (curr.length < prevText.length) {
      // 删除字符
      final re = RegExp(r' ?@[^@ ]{1,}$');
      if (re.hasMatch(curr)) {
        int lastAtIndex = curr.lastIndexOf('@');

        String newText = curr.substring(0, lastAtIndex);

        final u = curr.substring(lastAtIndex + 1).trim();
        if (u.isNotEmpty) {
          removeAtUser(u);
        }

        messageController.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newText.length),
        );
      }
    } else if (curr.length == prevText.length + 1) {
      final lastChar = curr.substring(curr.length - 1);
      final lastTwoChars = curr.length > 1
          ? curr.substring(curr.length - 2, curr.length - 1)
          : ' ';

      if (lastChar == '@' && [' ', '@'].contains(lastTwoChars)) {
        // ✅ 仅在真正输入“@”时触发
        handleSelectUser();
      }
    }
    prevText = curr;
  }

  Future<void> handleSelectUser() async {
    messageFocusNode.unfocus();

    await Future.delayed(const Duration(milliseconds: 300));

    final result = await Get.toNamed(Routes.CHOOSE_AT_USERS);
    if (result != null && result is List<LoginInfo>) {
      messageFocusNode.requestFocus();

      atUsers.value = result;

      String newText =
          '${messageController.text.substring(0, messageController.text.length - 1)}${result.map((e) => '@${e.name}').join(' ')} ';
      messageController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    }
  }

  Future<void> initData() async {
    await initLoginInfo();
  }

  Future<void> initLoginInfo() async {
    loginInfo.value = await userService.getLoginInfo();
  }

  formatMessage(String message) {
    if (!message.contains('@') || atUsers.isEmpty) {
      return message;
    }

    String newMessage = message;

    List<String> atUserNames = atUsers.map((e) => '@${e.name}').toList();

    for (var element in atUserNames) {
      newMessage = newMessage.replaceAll(element, '');
    }

    return newMessage.trim();
  }

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }

    messageFocusNode.unfocus();

    messages.add(MessageEntity(
      message: messageController.text,
      senderId: loginInfo.value?.id ?? '',
      senderName: loginInfo.value?.name ?? '',
      time: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
      senderAvatar: loginInfo.value?.avatar ?? '',
      messageType: MessageType.text,
    ));

    await dingtalkService.sendRobotMessage(
      classId: classId.value,
      message: formatMessage(messageController.text),
      atUsers: atUsers.map((e) => e.id ?? '').toList(),
      isAtAll: atUsers.isEmpty,
    );

    update(['update-messages']);
    messageController.clear();
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
