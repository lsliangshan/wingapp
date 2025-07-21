import 'package:get/get.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/teacher.dart';
import 'package:wingapp/services/toast.dart';

class TeacherDetailController extends GetxController {
  final TeacherService teacherService = TeacherService();
  ToastService toastService = ToastService();

  RxString id = ''.obs;

  Rx<Teacher> teacher = Teacher(id: '').obs;

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
}
