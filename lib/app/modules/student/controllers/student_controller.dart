import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/student.dart';

class StudentController extends GetxController {
  StudentService studentService = Get.find<StudentService>();

  RxString classId = ''.obs;

  RxList<Student> students = <Student>[].obs;

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
    classId.value =
        Get.arguments?['classId'] ?? Get.parameters['classId'] ?? '';
    initStudentsFuture = initData();
  }

  @override
  void onReady() {
    super.onReady();
    ever(classId, (val) => print('>>>>>>>>>>>.. classId: $val'));
  }

  Future<void> initData() async {
    await initStudents();
  }

  Future<void> initStudents() async {
    NormalResponse normalResponse = await studentService.getStudents(
      classId: classId.value,
      pageIndex: pageIndex.value,
      pageSize: pageSize.value,
      status: 'active',
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      print('>>>>>>>>>>>>>>> normalResponse.data: ${normalResponse.data}');
      if (normalResponse.data!['list'] != null &&
          normalResponse.data!['list'].isNotEmpty) {
        students.value = normalResponse.data!['list']
            .map<Student>((e) => Student.fromJson(e))
            .toList();
      } else {
        // 无数据
        students.clear();
      }
      update(['update-students']);
    }
  }

  Future<void> onRefresh() async {
    await initStudents();

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
      print('>>>>>>>>>>> ${newStudents.map((e) => e.toJson())}');
      totalCount.value = (totalCount.value + newStudents.length).toInt();
      update(['update-students']);
    }
  }
}
