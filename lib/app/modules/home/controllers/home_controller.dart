import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/app/modules/class/controllers/class_controller.dart';
import 'package:wingapp/app/modules/profile/controllers/profile_controller.dart';
import 'package:wingapp/app/modules/student/controllers/student_controller.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/services/message.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  MessageService messageService = Get.find<MessageService>();

  EventBus eventBus = Get.find<EventBus>();

  late PageController pageController;

  Rx<int> selectedTabIndex = 4.obs;

  RxList<String> initialedView = <String>[].obs;

  late TabController tabController;

  @override
  void onInit() {
    super.onInit();

    pageController = PageController(
      initialPage: selectedTabIndex.value,
    );

    initViewController();

    tabController = TabController(
        initialIndex: selectedTabIndex.value, length: tabs.length, vsync: this);

    tabController.addListener(() {
      changePage(tabController.index);
      if (tabController.index == 3) {
        eventBus.fire(TabChangeEvent(name: tabs[3]['name']));
      }
    });

    messageService.initMessageService();
  }

  void changePage(value) {
    selectedTabIndex.value = value;
    update(['update-selected-tab']);
    initViewController();
  }

  void changeTab(value) {
    changePage(value);
    // initViewController();
    tabController.animateTo(value, duration: Duration.zero);
  }

  void initViewController() {
    if (!initialedView.contains("ProfileView")) {
      initialedView.add('ProfileView');
      Get.put<ProfileController>(
        ProfileController(),
      );
    }
    if (!initialedView.contains("ClassView")) {
      initialedView.add('ClassView');
      Get.put<ClassController>(
        ClassController(),
      );
    }
    if (!initialedView.contains("StudentView")) {
      initialedView.add('StudentView');
      Get.put<StudentController>(
        StudentController(),
      );
    }
    // if (!initialedView.contains("EventsView")) {
    //   initialedView.add('EventsView');
    //   Get.put<EventsController>(
    //     EventsController(),
    //   );
    // }
    // if (!initialedView.contains("ContactView")) {
    //   initialedView.add('ContactView');
    //   Get.put<ContactController>(
    //     ContactController(),
    //   );
    // }
    // if (!initialedView.contains("ProfileView")) {
    //   initialedView.add('ProfileView');
    //   Get.put<ProfileController>(
    //     ProfileController(),
    //   );
    // }
  }

  void gotoCreateSpeech() {
    // Get.toNamed(Routes.CREATE_SPEECH);
  }

  void gotoAddGift() async {
    // await Get.toNamed(Routes.ADD_GIFT);
    // TODO: 刷新页面
  }
}
