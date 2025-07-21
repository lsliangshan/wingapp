import 'package:get/get.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/teacher.dart';

class ChooseTeacherController extends GetxController {
  TeacherService teacherService = Get.find<TeacherService>();

  RxList<Teacher> teachers = RxList<Teacher>();

  RxInt pageIndex = 1.obs;
  RxInt pageSize = 20.obs;
  RxInt totalCount = 0.obs;
  RxInt totalPage = 1.obs;

  late Future<void> initFuture;

  Rx<String> initTeacherId = ''.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments['teacherId'] != null) {
      initTeacherId.value = Get.arguments['teacherId'];
    }

    initFuture = getTeachers();
  }

  Future<void> getTeachers() async {
    NormalResponse normalResponse = await teacherService.getTeachers(
      pageIndex: pageIndex.value,
      pageSize: pageSize.value,
    );
    if (normalResponse.code == 200 &&
        normalResponse.data != null &&
        normalResponse.data!['list'] != null) {
      teachers.value = normalResponse.data!['list']
          .map<Teacher>((e) => Teacher.fromJson(e))
          .toList();
      totalCount.value = normalResponse.data!['totalCount'];
      totalPage.value = normalResponse.data!['totalPage'];
    }

    update(['update-teachers']);

    return Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> onRefresh() async {
    pageIndex.value = 1;
    await getTeachers();

    return await Future.delayed(const Duration(milliseconds: 1000));
  }

  void chooseTeacher(Teacher teacher) {
    Get.back(result: teacher);
  }
}
