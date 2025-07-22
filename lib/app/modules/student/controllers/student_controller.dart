import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/models/student_entity.dart';
import 'package:wingapp/services/student.dart';
import 'package:wingapp/services/toast.dart';

class StudentController extends GetxController {
  final String? classId;
  final String? teacherId;

  StudentController({this.classId, this.teacherId});

  ToastService toastService = Get.find<ToastService>();

  StudentService studentService = Get.find<StudentService>();

  RxList<StudentEntity> students = <StudentEntity>[].obs;

  late Future<void> initStudentsFuture;

  Rx<int> pageIndex = 1.obs;
  Rx<int> pageSize = 10.obs;
  Rx<int> totalCount = 0.obs;
  Rx<int> totalPage = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // if (Get.arguments != null && Get.arguments['classId'] != null) {
    //   classId.value = Get.arguments['classId']!;
    // }

    initStudentsFuture = initData();
  }

  Future<void> initData() async {
    await initStudents();
  }

  Future<void> initStudents() async {
    NormalResponse normalResponse = await studentService.getStudents(
      classId: classId,
      teacherId: teacherId,
      pageIndex: pageIndex.value,
      pageSize: pageSize.value,
      status: 'active',
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      if (normalResponse.data!['list'] != null &&
          normalResponse.data!['list'].isNotEmpty) {
        students.value = normalResponse.data!['list'].map<StudentEntity>((e) {
          StudentEntity std = StudentEntity.fromJson(e);
          std.classInfo = Class.fromJson(e['classInfo']);
          return std;
        }).toList();
      } else {
        // 无数据
        students.clear();
      }

      update(['update-students']);
    }
  }

  Future<void> onRefresh() async {
    await initStudents();
    toastService.showSuccess(message: 'toast.refresh.success'.tr);
    return await Future.delayed(const Duration(milliseconds: 1000));
  }

  void gotoStudentDetail({required String id}) {
    Get.toNamed(
      Routes.STUDENT_DETAIL,
      arguments: {
        'id': id,
      },
    );
  }

  Future<void> gotoAddStudent() async {
    var newStudents = await Get.toNamed(
      Routes.ADD_STUDENT,
    );
    if (newStudents != null && newStudents.isNotEmpty) {
      students.insertAll(0, newStudents);

      totalCount.value = (totalCount.value + newStudents.length).toInt();
      update(['update-students']);
    }
  }
}
