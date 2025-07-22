import 'package:get/get.dart';
import 'package:wingapp/app/modules/class/views/class_view.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/teacher.dart';
import 'package:wingapp/services/toast.dart';

class TeacherCount {
  int? classCount;
  int? studentCount;
  int? scheduleCount;

  TeacherCount({
    this.classCount,
    this.studentCount,
    this.scheduleCount,
  });

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'classCount': classCount,
      'studentCount': studentCount,
      'scheduleCount': scheduleCount,
    };
  }
}

class TeacherDetailController extends GetxController {
  final TeacherService teacherService = TeacherService();
  ToastService toastService = ToastService();

  RxString id = ''.obs;

  Rx<Teacher> teacher = Teacher(id: '').obs;

  Rx<TeacherCount> teacherCount = TeacherCount().obs;

  late Future<void> initTeacherDetailFuture;

  @override
  void onInit() {
    super.onInit();

    initTeacherDetailFuture = initData();
  }

  Future<void> initData() async {
    if (Get.arguments['id'] != null && Get.arguments['id'] != '') {
      id.value = Get.arguments['id'] as String;
    }

    await initTeacherDetail();

    await initTeacherCounts();
  }

  Future<void> initTeacherCounts() async {
    NormalResponse normalResponse = await teacherService.getTeacherCounts(
      teacherId: id.value,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      teacherCount.value = TeacherCount(
        classCount: normalResponse.data!['classCount'] ?? 0,
        studentCount: normalResponse.data!['studentCount'] ?? 0,
        scheduleCount: normalResponse.data!['scheduleCount'] ?? 0,
      );
    } else {
      teacherCount.value = TeacherCount(
        classCount: 0,
        studentCount: 0,
        scheduleCount: 0,
      );
    }
  }

  Future<void> initTeacherDetail() async {
    NormalResponse normalResponse = await teacherService.getTeacherDetail(
      id: id.value,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      teacher.value = Teacher.fromJson(normalResponse.data!);
    } else {}

    update(['update-teacher-detail']);
  }

  Future<void> onRefresh() async {
    await initTeacherDetail();

    return await Future.delayed(const Duration(milliseconds: 1000));
  }

  void gotoClasses() {
    Get.to(() => ClassView(teacherId: id.value));
  }
}
