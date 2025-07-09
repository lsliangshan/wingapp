import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/toast.dart';

class ClassDetailController extends GetxController {
  final ClassService classService = Get.find<ClassService>();
  final ToastService toastService = Get.find<ToastService>();

  late Future<void> initClassDetailFuture;
  RxString classId = ''.obs;

  Rx<Class> classDetail = Class(
    id: "",
    name: "",
    icon: "",
    teacherId: "",
    teacherUnionId: "",
    teacherName: "",
    teacherEnName: "",
    robotCode: "",
    openConversationId: "",
    chatId: "",
    link: "",
    assistant: "",
    createAt: "",
    updateAt: "",
  ).obs;

  @override
  void onInit() {
    super.onInit();

    initClassDetailFuture = initData();
  }

  Future<void> initData() async {
    if (Get.arguments != null && Get.arguments['classId'] != null) {
      classId.value = Get.arguments['classId'];
    }

    await initClassDetail();

    return await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> initClassDetail() async {
    NormalResponse normalResponse = await classService.getClassDetailByClassId(
      classId: classId.value,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      classDetail.value = Class.fromJson(normalResponse.data!);
      update(['update-class-detail']);
    } else {
      toastService.showError(message: 'class_detail.init.failed'.tr);
    }
  }

  void goToSendRobotMessage() {
    Get.toNamed(Routes.SEND_ROBOT_MESSAGE, arguments: {
      'robotCode': classDetail.value.robotCode,
      'openConversationId': classDetail.value.openConversationId,
    });
  }
}
