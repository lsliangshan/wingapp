import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/teacher.dart';
import 'package:wingapp/services/toast.dart';

class TeacherController extends GetxController {
  ToastService toastService = Get.find<ToastService>();
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

  Future<void> onRefresh() async {
    pageIndex.value = 1;
    await getTeachers();

    return await Future.delayed(const Duration(milliseconds: 1000)).then(
      (_) {
        toastService.showSuccess(message: 'toast.refresh.success'.tr);
        update(['update-teachers']);
      },
    );
  }

  Future<void> loadMoreTeachers() async {
    if (pageIndex.value < totalPage.value) {
      pageIndex.value++;
      getTeachers();
    }
  }

  void gotoAddTeacher() async {
    var newTeachers = await Get.toNamed(
      Routes.ADD_TEACHER,
    );
    if (newTeachers != null && newTeachers.isNotEmpty) {
      teachers.insertAll(0, newTeachers);
      totalCount.value = (totalCount.value + newTeachers.length).toInt();
      update(['update-teachers']);
    }
  }

  void gotoTeacherDetail({required String id}) {
    Get.toNamed(Routes.TEACHER_DETAIL, arguments: {'id': id});
  }
}
