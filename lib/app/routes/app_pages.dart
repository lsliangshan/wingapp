import 'package:get/get.dart';

import '../modules/add_class/bindings/add_class_binding.dart';
import '../modules/add_class/views/add_class_view.dart';
import '../modules/add_teacher/bindings/add_teacher_binding.dart';
import '../modules/add_teacher/views/add_teacher_view.dart';
import '../modules/choose_teacher/bindings/choose_teacher_binding.dart';
import '../modules/choose_teacher/views/choose_teacher_view.dart';
import '../modules/class/bindings/class_binding.dart';
import '../modules/class/views/class_view.dart';
import '../modules/class_detail/bindings/class_detail_binding.dart';
import '../modules/class_detail/views/class_detail_view.dart';
import '../modules/discovery/bindings/discovery_binding.dart';
import '../modules/discovery/views/discovery_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/schedule/bindings/schedule_binding.dart';
import '../modules/schedule/views/schedule_view.dart';
import '../modules/send_robot_message/bindings/send_robot_message_binding.dart';
import '../modules/send_robot_message/views/send_robot_message_view.dart';
import '../modules/student/bindings/student_binding.dart';
import '../modules/student/views/student_view.dart';
import '../modules/teacher/bindings/teacher_binding.dart';
import '../modules/teacher/views/teacher_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CLASS,
      page: () => const ClassView(),
      binding: ClassBinding(),
    ),
    GetPage(
      name: _Paths.TEACHER,
      page: () => const TeacherView(),
      binding: TeacherBinding(),
    ),
    GetPage(
      name: _Paths.STUDENT,
      page: () => const StudentView(),
      binding: StudentBinding(),
    ),
    GetPage(
      name: _Paths.SCHEDULE,
      page: () => const ScheduleView(),
      binding: ScheduleBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DISCOVERY,
      page: () => const DiscoveryView(),
      binding: DiscoveryBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TEACHER,
      page: () => const AddTeacherView(),
      binding: AddTeacherBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CLASS,
      page: () => const AddClassView(),
      binding: AddClassBinding(),
    ),
    GetPage(
      name: _Paths.CHOOSE_TEACHER,
      page: () => const ChooseTeacherView(),
      binding: ChooseTeacherBinding(),
    ),
    GetPage(
      name: _Paths.CLASS_DETAIL,
      page: () => ClassDetailView(
        classId: Get.arguments['classId'] ?? '',
      ),
      binding: ClassDetailBinding(),
    ),
    GetPage(
      name: _Paths.SEND_ROBOT_MESSAGE,
      page: () => SendRobotMessageView(
        robotCode: Get.arguments['robotCode'] ?? '',
        openConversationId: Get.arguments['openConversationId'] ?? '',
      ),
      binding: SendRobotMessageBinding(),
    ),
  ];
}
