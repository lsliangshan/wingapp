import 'package:drift/drift.dart' show Value;
import 'package:event_bus/event_bus.dart';
import 'package:get/get.dart' hide Value;
import 'package:wingapp/app/modules/student/views/student_view.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/student.dart';
import 'package:wingapp/services/toast.dart';
import 'package:wingapp/services/user.dart';

class ClassDetailController extends GetxController {
  final StudentService studentService = Get.find<StudentService>();
  final ClassService classService = Get.find<ClassService>();
  final UserService userService = Get.find<UserService>();
  final ToastService toastService = Get.find<ToastService>();

  final EventBus eventBus = Get.find<EventBus>();

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

  Rx<LoginInfo?> loginInfo = Rx<LoginInfo?>(null);

  RxBool get isAdminTeacher => (loginInfo.value?.admin == '1').obs;

  @override
  void onInit() {
    super.onInit();

    eventBus.on<LoginEvent>().listen((event) {
      loginInfo.value = event.loginInfo;
    });

    eventBus.on<LogoutEvent>().listen((event) {
      loginInfo.value = null;
    });

    initClassDetailFuture = initData();
  }

  Future<void> initData() async {
    if (Get.arguments != null && Get.arguments['classId'] != null) {
      classId.value = Get.arguments['classId'];
    }

    await initLoginInfo();

    await initClassDetail();

    await initStudentsCount();

    return await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> initLoginInfo() async {
    loginInfo.value = await userService.getLoginInfo();
  }

  Future<void> onRefresh() async {
    await initData();
    toastService.showSuccess(message: 'toast.refresh.success'.tr);
    return await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> initStudentsCount() async {
    NormalResponse normalResponse = await studentService.getStudentsCount(
      classId: classId.value,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      studentsCount.value = normalResponse.data!['total'];
    } else {
      studentsCount.value = 0;
    }
    update(['update-class-detail']);
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

  Future<void> goToStudents() async {
    // Get.toNamed(Routes.STUDENT, arguments: {
    //   'classId': classId.value,
    // });
    await Get.to(() => StudentView(classId: classId.value));
    await initData();
  }

  Future<void> gotoChooseTeacher() async {
    final result = await Get.toNamed(Routes.CHOOSE_TEACHER, arguments: {
      'teacherId': classDetail.value.teacherId,
    });
    if (result != null) {
      // 修改班级老师信息
      NormalResponse normalResponse = await classService.updateClassTeacher(
        classId: classId.value,
        teacherId: result.id,
      );

      if (normalResponse.code == 200) {
        toastService.showSuccess(message: 'toast.update.success'.tr);
        classDetail.value = classDetail.value.copyWith(
          teacherId: Value<String?>(result.id),
          teacherName: Value<String?>(result.name),
          teacherEnName: Value<String?>(result.enName),
          teacherUnionId: Value<String?>(result.unionId),
        );
        update(['update-class-detail']);
      } else {
        toastService.showError(message: 'toast.update.failed'.tr);
      }
    }
  }
}
