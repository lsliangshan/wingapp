import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/modules/add_class/views/add_class_view.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/toast.dart';
import 'package:wingapp/services/user.dart';

class ClassController extends GetxController {
  final String? teacherId;
  ClassController({this.teacherId});

  final EventBus eventBus = Get.find<EventBus>();
  ToastService toastService = Get.find<ToastService>();
  ClassService classService = Get.find<ClassService>();
  UserService userService = Get.find<UserService>();

  ScrollController scrollController = ScrollController();

  RxList<Class> classes = RxList<Class>();

  Rx<LoginInfo?> loginInfo = Rx<LoginInfo?>(null);

  RxInt pageIndex = 1.obs;
  RxInt pageSize = 20.obs;
  RxInt totalCount = 0.obs;
  RxInt totalPage = 1.obs;

  Rx<bool> isLoadingMore = false.obs;

  late Future<void> initClassesFuture;

  @override
  void onInit() {
    super.onInit();
    eventBus.on<LoginEvent>().listen((event) {
      loginInfo.value = event.loginInfo;
    });

    eventBus.on<LogoutEvent>().listen((event) {
      loginInfo.value = null;
    });

    eventBus.on<NeedLoginCallbackEvent>().listen((event) {
      if (event.isSuccess) {
        // 登录成功
        initClassesFuture = initData();
      } else {
        // 登录失败
        toastService.showError(message: 'toast.login.failed'.tr);
      }
    });

    initClassesFuture = initData();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMoreClasses();
      }
    });
  }

  void needLogin() {
    eventBus.fire(NeedLoginEvent());
  }

  void gotoClassDetail({required String classId}) {
    Get.toNamed(
      Routes.CLASS_DETAIL,
      arguments: {'classId': classId},
    );
  }

  Future<void> initData() async {
    await initLoginInfo();

    await getClasses();

    return await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> initLoginInfo() async {
    loginInfo.value = await userService.getLoginInfo();
  }

  Future<void> getClasses() async {
    NormalResponse normalResponse = await classService.getClasses(
      pageIndex: pageIndex.value,
      pageSize: pageSize.value,
      teacherId: teacherId ?? loginInfo.value?.id,
      ignoreAdmin: teacherId != null && teacherId!.isNotEmpty,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      if (normalResponse.data!['list'] != null &&
          normalResponse.data!['list'].isNotEmpty) {
        if (pageIndex.value == 1) {
          classes.clear();
        }

        final cls = normalResponse.data!['list']
            .map<Class>((e) => Class.fromJson(e))
            .toList();
        classes.addAll(cls);
        totalCount.value = normalResponse.data!['totalCount'];
        totalPage.value = normalResponse.data!['totalPage'];
      } else {
        // 无数据
      }
    }

    update(['update-classes']);
  }

  Future<void> onRefresh() async {
    pageIndex.value = 1;
    await getClasses();

    return await Future.delayed(const Duration(milliseconds: 1000)).then(
      (_) {
        toastService.showSuccess(message: 'toast.refresh.success'.tr);
        update(['update-classes']);
      },
    );
  }

  Future<void> loadMoreClasses() async {
    if (isLoadingMore.value) {
      return;
    }

    if (pageIndex.value >= totalPage.value) {
      return;
    }

    isLoadingMore.value = true;
    pageIndex.value++;
    await getClasses();

    isLoadingMore.value = false;
  }

  void gotoAddClass() async {
    var newClasses = await Get.to(
      () => AddClassView(
        teacherId: loginInfo.value?.id ?? '',
      ),
    );
    if (newClasses != null && newClasses.isNotEmpty) {
      classes.insertAll(0, newClasses);
      totalCount.value = (totalCount.value + newClasses.length).toInt();
      update(['update-classes']);
    }
  }
}
