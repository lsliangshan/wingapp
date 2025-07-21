import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/models/student_entity.dart';
import 'package:wingapp/services/student.dart';
import 'package:wingapp/services/toast.dart';

class StudentDetailController extends GetxController {
  final StudentService studentService = StudentService();
  ToastService toastService = ToastService();

  RxString id = ''.obs;

  Rx<StudentEntity> student = StudentEntity(id: '').obs;

  late Future<void> initStudentDetailFuture;

  @override
  void onInit() {
    super.onInit();

    initStudentDetailFuture = initData();
  }

  Future<void> initData() async {
    if (Get.arguments['id'] != null && Get.arguments['id'] != '') {
      id.value = Get.arguments['id'] as String;
    }

    await initStudentDetail();
  }

  Future<void> initStudentDetail() async {
    NormalResponse normalResponse = await studentService.getStudentDetail(
      id: id.value,
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      student.value = StudentEntity.fromJson(normalResponse.data!);
    } else {}

    update(['update-student-detail']);
  }

  Future<void> onRefresh() async {
    await initStudentDetail();

    return await Future.delayed(const Duration(milliseconds: 1000));
  }

  Future<void> gotoChooseClass() async {
    final result = await Get.toNamed(
      Routes.CHOOSE_CLASS,
      arguments: {
        'classId': student.value.classId,
      },
    );
    if (result != null &&
        result['classInfo'] != null &&
        result['classInfo'].id != student.value.classId) {
      NormalResponse normalResponse = await studentService.updateStudentClass(
        id: student.value.id,
        classId: result['classInfo'].id,
        teacherId: result['classInfo'].teacherId,
      );

      if (normalResponse.code == 200 && normalResponse.data != null) {
        student.value.classId = result['classInfo'].id;
        student.value.teacherId = result['classInfo'].teacherId;
        student.value.classInfo = result['classInfo'];
        update(['update-student-detail']);
        toastService.showSuccess(message: 'toast.update.success'.tr);
      } else {
        toastService.showError(message: 'toast.update.failed'.tr);
      }
    }
  }
}
