import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/student.dart';
import 'package:wingapp/services/toast.dart';

class ClassDetailController extends GetxController {
  final StudentService studentService = Get.find<StudentService>();
  final ClassService classService = Get.find<ClassService>();
  final ToastService toastService = Get.find<ToastService>();

  late Future<void> initClassDetailFuture;
  RxString classId = ''.obs;

  Rx<int> studentsCount = 0.obs;

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

    await initStudentsCount();

    return await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> initStudentsCount() async {
    NormalResponse normalResponse = await studentService.getStudentsCount(
      classId: classId.value,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      studentsCount.value = normalResponse.data!['total'];
      update(['update-students-count']);
    } else {
      studentsCount.value = 0;
    }
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
      'classId': classId.value,
    });
  }

  void goToAttachments() {
    Get.toNamed(Routes.CLASS_ATTACHMENTS, arguments: {
      'classId': classId.value,
    });
  }

  void goToStudents() {
    Get.toNamed(Routes.STUDENT, arguments: {
      'classId': classId.value,
    });
  }
}
