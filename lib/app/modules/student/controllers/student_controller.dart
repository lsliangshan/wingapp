import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/events/events.dart';
import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/models/student_entity.dart';
import 'package:wingapp/services/student.dart';
import 'package:wingapp/services/teacher.dart';
import 'package:wingapp/services/toast.dart';

class StudentController extends GetxController {
  final String? classId;
  final String? teacherId;

  StudentController({this.classId, this.teacherId});

  EventBus eventBus = Get.find<EventBus>();

  ToastService toastService = Get.find<ToastService>();

  StudentService studentService = Get.find<StudentService>();
  TeacherService teacherService = Get.find<TeacherService>();

  ScrollController scrollController = ScrollController();

  RxList<StudentEntity> students = <StudentEntity>[].obs;

  late Future<void> initStudentsFuture;

  Rx<int> pageIndex = 1.obs;
  Rx<int> pageSize = 10.obs;
  Rx<int> totalCount = 0.obs;
  Rx<int> totalPage = 0.obs;

  Rx<bool> isLoadingMore = false.obs;

  Rx<LoginInfo?> loginInfo = Rx<LoginInfo?>(null);

  @override
  void onInit() {
    super.onInit();

    // if (Get.arguments != null && Get.arguments['classId'] != null) {
    //   classId.value = Get.arguments['classId']!;
    // }

    eventBus.on<LoginEvent>().listen((event) {
      loginInfo.value = event.loginInfo;
    });

    eventBus.on<LogoutEvent>().listen((event) {
      loginInfo.value = null;
    });

    initStudentsFuture = initData();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        loadMore();
      }
    });
  }

  Future<void> initData() async {
    await initLoginInfo();
    await initStudents();
  }

  Future<void> initLoginInfo() async {
    loginInfo.value = await teacherService.getLoginInfo();
    if (loginInfo.value != null) {
      eventBus.fire(LoginEvent(loginInfo.value!));
    }
  }

  Future<void> initStudents() async {
    NormalResponse normalResponse = await studentService.getStudents(
      classId: classId,
      teacherId: teacherId ?? loginInfo.value?.id,
      pageIndex: pageIndex.value,
      pageSize: pageSize.value,
      status: 'active',
    );

    if (normalResponse.code == 200 && normalResponse.data != null) {
      if (normalResponse.data!['list'] != null &&
          normalResponse.data!['list'].isNotEmpty) {
        if (pageIndex.value == 1) {
          students.clear();
        }
        final stds = normalResponse.data!['list'].map<StudentEntity>((e) {
          StudentEntity std = StudentEntity.fromJson(e);
          if (e['classInfo'] != null && e['classInfo']['id'] != null) {
            std.classInfo = Class.fromJson(e['classInfo']);
          }
          return std;
        }).toList();

        students.addAll(stds);
        totalCount.value = normalResponse.data!['totalCount'];
        totalPage.value = normalResponse.data!['totalPage'];
        update(['update-students']);
      } else {
        // 无数据
      }
    }
  }

  Future<void> onRefresh() async {
    pageIndex.value = 1;
    await initData();
    toastService.showSuccess(message: 'toast.refresh.success'.tr);
    return await Future.delayed(const Duration(milliseconds: 1000));
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value) {
      return;
    }

    if (pageIndex.value >= totalPage.value) {
      return;
    }

    isLoadingMore.value = true;

    pageIndex.value++;
    await initStudents();

    isLoadingMore.value = false;
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
