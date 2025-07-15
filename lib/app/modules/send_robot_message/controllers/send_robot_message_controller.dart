import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/dingtalk.dart';
import 'package:wingapp/services/message.dart';
import 'package:wingapp/services/student.dart';
import 'package:wingapp/services/user.dart';

class SendRobotMessageController extends GetxController {
  final StudentService studentService = Get.find<StudentService>();
  final MessageService messageService = Get.find<MessageService>();
  final EventBus eventBus = Get.find<EventBus>();
  final UserService userService = Get.find<UserService>();
  final DingtalkService dingtalkService = Get.find<DingtalkService>();

  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 10000,
  );

  final TextEditingController messageController = TextEditingController();

  final FocusNode messageFocusNode = FocusNode();

  Rx<bool> hasNewMessage = false.obs;

  String prevText = '';

  Rx<LoginInfo?> loginInfo = Rx<LoginInfo?>(null);

  RxList<LoginInfo> atUsers = <LoginInfo>[].obs;

  RxList<LoginInfo> users = <LoginInfo>[].obs;

  RxString robotCode = ''.obs;
  RxString openConversationId = ''.obs;
  RxString classId = ''.obs;

  Rx<bool> isLoadingMoreMessages = false.obs;

  Rx<double> maxScrollExtent = 0.0.obs;

  RxList<Message> messages = <Message>[].obs;

  Rx<int> pageIndex = 1.obs;
  Rx<int> pageSize = 10.obs;
  Rx<int> totalCount = 0.obs;
  Rx<int> totalPage = 0.obs;

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

    messageService.onMessageEvent(
      classId: classId.value,
      callback: (message) {
        messages.add(message);
        hasNewMessage.value = true;
        update(['update-messages']);
      },
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.minScrollExtent) {
        loadMoreMessages();
      }
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent - 100) {
        hasNewMessage.value = false;
      }
      if (maxScrollExtent.value == 0 ||
          maxScrollExtent.value < scrollController.position.maxScrollExtent) {
        maxScrollExtent.value = scrollController.position.maxScrollExtent + 132;
      }
    });
  }

  @override
  void onClose() {
    messageService.offMessageEvent(classId: classId.value);
    super.onClose();
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

        // final u = curr.substring(lastAtIndex + 1).trim();
        // if (u.isNotEmpty) {
        //   removeAtUser(u);
        // }

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
    if (users.isEmpty) {
      return;
    }

    messageFocusNode.unfocus();

    await Future.delayed(const Duration(milliseconds: 300));

    final result = await Get.toNamed(Routes.CHOOSE_AT_USERS, arguments: {
      'classId': classId.value,
    });
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

  Future<void> getMessages({
    int? pIndex,
  }) async {
    NormalResponse response = await messageService.getMessages(
      classId: classId.value,
      pageIndex: pIndex ?? pageIndex.value,
      pageSize: pageSize.value,
    );

    await Future.delayed(const Duration(milliseconds: 800));

    if (response.code == 200 && response.data != null) {
      if (pIndex == 1) {
        messages.clear();
      }
      messages.insertAll(0, response.data['list']);
      pageIndex.value = pIndex ?? pageIndex.value;
      totalCount.value = response.data['totalCount'];
      totalPage.value = response.data['totalPage'];
    }
    isLoadingMoreMessages.value = false;
    update(['update-messages']);
  }

  Future<void> loadMoreMessages() async {
    if (pageIndex.value >= totalPage.value || isLoadingMoreMessages.value) {
      return;
    }
    isLoadingMoreMessages.value = true;
    update(['update-messages']);
    await getMessages(pIndex: pageIndex.value + 1);

    if (pageIndex.value != totalPage.value) {
      scrollController.animateTo(
        48,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> initData() async {
    await initLoginInfo();
    await getMessages();
  }

  Future<void> initLoginInfo() async {
    loginInfo.value = await userService.getLoginInfo();

    // users.add(loginInfo.value!);
    // users.add(LoginInfo(
    //   id: '1',
    //   name: '张三',
    //   avatar: 'https://img.yzcdn.cn/vant/cat.jpeg',
    //   unionId: '1',
    // ));

    NormalResponse response = await studentService.getStudents(
      classId: classId.value,
      pageIndex: 1,
      pageSize: 100,
    );

    if (response.code == 200 &&
        response.data != null &&
        response.data['list'] != null) {
      users.value = response.data['list']
          .map<LoginInfo>((e) => LoginInfo.fromJson(e))
          .toList();
    }
  }

  formatMessage(String message) {
    if (!message.contains('@')) {
      return {
        'message': message,
        'atUsers': [],
      };
    }

    String newMessage = message;

    final re = RegExp(r'[ @]?@([^ @]{1,})', multiLine: true);
    List<LoginInfo> atUserNames = re
        .allMatches(newMessage)
        .map((e) => e.group(1)!)
        .toList()
        .toSet()
        .toList()
        .map((e) => users.firstWhere((element) => element.name == e,
            orElse: () => LoginInfo(
                  id: '',
                  name: e,
                  avatar: '',
                  unionId: '',
                )))
        .where((element) => element.id != null && element.id!.isNotEmpty)
        .toList();

    for (var element in atUserNames) {
      newMessage = newMessage.replaceAll('@${element.name}', '');
    }

    return {
      'message': newMessage.trim(),
      'atUsers': atUserNames.isEmpty ? [] : atUserNames,
    };
  }

  Future<void> sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }

    final message = formatMessage(messageController.text);

    messageFocusNode.unfocus();

    Message newMessage = Message(
      id: Uuid().v4(),
      classId: classId.value,
      content: messageController.text,
      senderId: loginInfo.value?.id ?? '',
      senderName: loginInfo.value?.name ?? '',
      senderAvatar: loginInfo.value?.avatar ?? '',
      type: 'text',
      isRobot: false,
      from: 'wingapp',
      createAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
    );
    messages.add(newMessage);

    await messageService.sendMessage(
      id: newMessage.id,
      classId: newMessage.classId,
      content: newMessage.content,
      senderId: newMessage.senderId,
      senderName: newMessage.senderName,
      senderAvatar: newMessage.senderAvatar,
      type: newMessage.type,
      isRobot: newMessage.isRobot,
      from: newMessage.from,
    );

    await dingtalkService.sendRobotMessage(
      classId: classId.value,
      message: message['message'],
      atUsers: message['atUsers'].isNotEmpty
          ? message['atUsers'].map<String>((LoginInfo e) => e.id ?? '').toList()
          : [],
      isAtAll: message['atUsers'].isEmpty,
    );

    update(['update-messages']);
    messageController.clear();
    scrollToBottom();
  }

  void scrollToBottom({
    bool useAnimation = true,
  }) {
    if (useAnimation) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  void scrollToNewMessage() {
    scrollController.animateTo(
      maxScrollExtent.value + 10,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );

    hasNewMessage.value = false;
    maxScrollExtent.value = scrollController.position.maxScrollExtent + 132;
  }
}
