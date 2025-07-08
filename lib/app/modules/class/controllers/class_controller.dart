import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/toast.dart';

class ClassController extends GetxController {
  ToastService toastService = Get.find<ToastService>();
  ClassService classService = Get.find<ClassService>();

  RxList<Class> classes = RxList<Class>();

  RxInt pageIndex = 1.obs;
  RxInt pageSize = 20.obs;
  RxInt totalCount = 0.obs;
  RxInt totalPage = 1.obs;

  @override
  void onInit() {
    super.onInit();
    getClasses();
  }

  Future<void> getClasses() async {
    NormalResponse normalResponse = await classService.getClasses(
      pageIndex: pageIndex.value,
      pageSize: pageSize.value,
    );
    if (normalResponse.code == 200 &&
        normalResponse.data != null &&
        normalResponse.data!['list'] != null) {
      classes.value = normalResponse.data!['list']
          .map<Class>((e) => Class.fromJson(e))
          .toList();
      totalCount.value = normalResponse.data!['totalCount'];
      totalPage.value = normalResponse.data!['totalPage'];
    }

    update(['update-classes']);
  }

  Future<void> onRefresh() async {
    pageIndex.value = 1;
    await getClasses();

    return await Future.delayed(const Duration(milliseconds: 1000)).then(
      (_) {
        toastService.showSuccess(message: 'toast.refresh.success'.tr);
        update(['update-classes']);
      },
    );
  }

  Future<void> loadMoreClasses() async {
    if (pageIndex.value < totalPage.value) {
      pageIndex.value++;
      getClasses();
    }
  }

  void gotoAddClass() async {
    var newClasses = await Get.toNamed(
      Routes.ADD_CLASS,
    );
    if (newClasses != null && newClasses.isNotEmpty) {
      classes.insertAll(0, newClasses);
      totalCount.value = (totalCount.value + newClasses.length).toInt();
      update(['update-classes']);
    }
  }
}
