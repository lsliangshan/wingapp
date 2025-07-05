import 'package:get/get.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/teacher.dart';

class TeacherController extends GetxController {
  TeacherService teacherService = Get.find<TeacherService>();

  RxList<Teacher> teachers = RxList<Teacher>();

  RxInt pageIndex = 1.obs;
  RxInt pageSize = 20.obs;
  RxInt totalCount = 0.obs;
  RxInt totalPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getTeachers();
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
  }

  Future<void> loadMoreTeachers() async {
    if (pageIndex.value < totalPage.value) {
      pageIndex.value++;
      getTeachers();
    }
  }
}
