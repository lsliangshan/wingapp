import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/toast.dart';
import 'package:wingapp/services/user.dart';

class ClassController extends GetxController {
  final EventBus eventBus = Get.find<EventBus>();
  ToastService toastService = Get.find<ToastService>();
  ClassService classService = Get.find<ClassService>();
  UserService userService = Get.find<UserService>();

  RxList<Class> classes = RxList<Class>();

  Rx<LoginInfo?> loginInfo = Rx<LoginInfo?>(null);

  RxInt pageIndex = 1.obs;
  RxInt pageSize = 20.obs;
  RxInt totalCount = 0.obs;
  RxInt totalPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    eventBus.on<LoginEvent>().listen((event) {
      loginInfo.value = event.loginInfo;
    });

    eventBus.on<LogoutEvent>().listen((event) {
      loginInfo.value = null;
    });

    initData();
  }

  Future<void> initData() async {
    await initLoginInfo();

    getClasses();
  }

  Future<void> initLoginInfo() async {
    loginInfo.value = await userService.getLoginInfo();
  }

  Future<void> getClasses() async {
    NormalResponse normalResponse = await classService.getClasses(
      pageIndex: pageIndex.value,
      pageSize: pageSize.value,
      teacherId: loginInfo.value?.id,
    );
    if (normalResponse.code == 200 &&
        normalResponse.data != null &&
        normalResponse.data!['list'] != null) {
      classes.value = normalResponse.data!['list']
          .map<Class>((e) => Class.fromJson(e))
          .toList();
      totalCount.value = normalResponse.data!['totalCount'];
      totalPage.value = normalResponse.data!['totalPage'];
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
    if (pageIndex.value < totalPage.value) {
      pageIndex.value++;
      getClasses();
    }
  }

  void gotoAddClass() async {
    var newClasses = await Get.toNamed(
      Routes.ADD_CLASS,
    );
    if (newClasses != null && newClasses.isNotEmpty) {
      classes.insertAll(0, newClasses);
      totalCount.value = (totalCount.value + newClasses.length).toInt();
      update(['update-classes']);
    }
  }
}
