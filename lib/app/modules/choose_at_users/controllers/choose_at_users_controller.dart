import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/services/user.dart';

class ChooseAtUsersController extends GetxController {
  final UserService userService = Get.find<UserService>();

  final TextEditingController keywordController = TextEditingController();
  final FocusNode keywordFocusNode = FocusNode();

  Rx<LoginInfo?> loginInfo = Rx<LoginInfo?>(null);

  RxList<LoginInfo> users = <LoginInfo>[].obs;

  // 是否支持多选
  RxBool multiAt = false.obs;

  RxList<LoginInfo> selectedUsers = <LoginInfo>[].obs;

  @override
  void onInit() {
    super.onInit();

    keywordController.addListener(() {
      if (keywordFocusNode.hasFocus) {
        update(['update-keyword']);
      }
    });

    initUsers();
  }

  Future<void> initUsers() async {
    loginInfo.value = await userService.getLoginInfo();
    users.add(loginInfo.value!);
    users.add(LoginInfo(
      id: '1',
      name: '张三',
      avatar: 'https://img.yzcdn.cn/vant/cat.jpeg',
      unionId: '1',
    ));
    update(['update-selected-users']);
  }

  void toggleAtUser({
    required LoginInfo user,
    required bool isAdd,
  }) {
    if (isAdd) {
      selectedUsers.add(user);
    } else {
      selectedUsers.remove(user);
    }

    update(['update-selected-users']);
  }

  void chooseAtUser({required LoginInfo user}) {
    Get.back(result: [user]);
  }

  void chooseAtUsers() {
    Get.back(result: selectedUsers.toList());
  }

  void setMultiAt(bool value) {
    selectedUsers.clear();
    multiAt.value = value;
    update(['update-selected-users']);
  }
}
