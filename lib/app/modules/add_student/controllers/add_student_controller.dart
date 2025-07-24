import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/app/routes/app_pages.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/models/student_entity.dart';
import 'package:wingapp/services/class.dart';
import 'package:wingapp/services/date.dart';
import 'package:wingapp/services/student.dart';
import 'package:wingapp/services/toast.dart';

class AddStudentFormData {
  String? name;
  String? enName;
  String? gender;
  String? genderName;
  String? id;
  String? avatar;
  String? stateCode;
  String? mobile;
  String? unionId;
  String? openId;
  String? classId;
  String? className;
  String? teacherId;
  String? teacherName;
  String? teacherEnName;
  String? birthday;

  AddStudentFormData({
    this.name,
    this.enName,
    this.gender,
    this.genderName,
    this.id,
    this.avatar,
    this.stateCode,
    this.mobile,
    this.unionId,
    this.openId,
    this.classId,
    this.className,
    this.teacherId,
    this.teacherName,
    this.teacherEnName,
    this.birthday,
  });

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'enName': enName,
      'gender': gender,
      'genderName': genderName,
      'id': id,
      'avatar': avatar,
      'mobile': mobile,
      'unionId': unionId,
      'openId': openId,
      'classId': classId,
      'className': className,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'teacherEnName': teacherEnName,
      'birthday': birthday,
    };
  }
}

class AddStudentController extends GetxController {
  ToastService toastService = Get.find<ToastService>();
  ClassService classService = Get.find<ClassService>();
  StudentService studentService = Get.find<StudentService>();
  DateService dateService = Get.find<DateService>();

  final formKey = GlobalKey<FormState>();

  InAppWebViewController? webViewController;

  TextEditingController nameController = TextEditingController();
  TextEditingController enNameController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode enNameFocusNode = FocusNode();

  Rx<AddStudentFormData> formData = AddStudentFormData(
    gender: genders[0]['value'],
    genderName: genders[0]['label'],
    mobile: '17319138715',
    unionId: 'lZ0iiKmh8gdN9XWafHBYMiPQiEiE',
    openId: 'hsMwUhlAwbBjjpAziSgcAwgiEiE',
    avatar: '',
    id: '0326286829462575714',
    classId: '',
    className: '',
    teacherId: '',
    teacherName: '',
    teacherEnName: '',
    birthday: '',
  ).obs;

  List<StudentEntity> newStudents = [];

  RxList<Class> classes = RxList<Class>();

  late Future<void> initAddStudentFuture;

  @override
  void onInit() {
    super.onInit();
    nameController.addListener(() {
      formData.value.name = nameController.text;
      update(['update-form-data']);
    });
    enNameController.addListener(() {
      formData.value.enName = enNameController.text;
      update(['update-form-data']);
    });

    initAddStudentFuture = initData();
  }

  @override
  void onClose() {
    InAppWebViewController.clearAllCache();
    super.onClose();
  }

  void clearName() {
    nameController.clear();
    formData.value.name = null;
    update(['update-form-data']);
  }

  void clearEnName() {
    enNameController.clear();
    formData.value.enName = null;
    update(['update-form-data']);
  }

  void onWebViewCreated(InAppWebViewController controller) {
    webViewController = controller;

    controller.addJavaScriptHandler(
      handlerName: 'dingtalkLoginCallback',
      callback: (args) {
        print('>>>>> dingtalkLoginCallback: ${args[0]}');
        if (args[0]['code'] == 200 && args[0]['data'] != null) {
          formData.value.id = args[0]['data']['id'] ?? '';
          formData.value.avatar = args[0]['data']['avatar'] ?? '';
          formData.value.mobile = args[0]['data']['mobile'] ?? '';
          formData.value.unionId = args[0]['data']['unionId'] ?? '';
          formData.value.openId = args[0]['data']['openId'] ?? '';
          update(['update-dingtalk-login']);
        }
        return {
          "code": 200,
        };
      },
    );
  }

  Future<void> initData() async {
    await getClasses();

    return await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> getClasses() async {
    NormalResponse normalResponse = await classService.getClasses(
      pageIndex: 1,
      pageSize: 100,
      teacherId: '',
    );
    if (normalResponse.code == 200 && normalResponse.data != null) {
      if (normalResponse.data!['list'] != null &&
          normalResponse.data!['list'].isNotEmpty) {
        classes.value = normalResponse.data!['list']
            .map<Class>((e) => Class.fromJson(e))
            .toList();
      } else {
        // 无数据
        classes.clear();
      }
    }

    update(['update-classes']);
  }

  void chooseGender() {
    Get.bottomSheet(
      SafeArea(
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('bottom_sheet.choose_gender.title'.tr),
                trailing: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: SvgPicture.asset(
                    'assets/svgs/icon_close.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      Get.theme.hintColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(alpha: 0.1),
              ),
              Container(
                height: 132,
                padding: const EdgeInsets.only(bottom: 32),
                child: ListView.builder(
                  itemCount: genders.length,
                  itemExtent: 48,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(genders[index]['label'] ?? ''),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      trailing: formData.value.gender == genders[index]['value']
                          ? SvgPicture.asset(
                              'assets/svgs/icon_checked.svg',
                              width: 24,
                              height: 24,
                              colorFilter: ColorFilter.mode(
                                Get.theme.primaryColor,
                                BlendMode.srcIn,
                              ),
                            )
                          : null,
                      onTap: () {
                        formData.value.gender = genders[index]['value'];
                        formData.value.genderName = genders[index]['label'];
                        update(['update-form-data']);
                        Get.back();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> chooseClass() async {
    final result = await Get.toNamed(
      Routes.CHOOSE_CLASS,
      arguments: {
        'classId': formData.value.classId,
      },
    );
    if (result != null && result['classInfo'] != null) {
      formData.value.classId = result['classInfo'].id;
      formData.value.className = result['classInfo'].name;
      formData.value.teacherId = result['classInfo'].teacherId;
      formData.value.teacherName = result['classInfo'].teacherName;
      formData.value.teacherEnName = result['classInfo'].teacherEnName;
      update(['update-form-data']);
    }
  }

  void setBirthday() async {
    DateTime? result = await dateService.showDatePicker(
      initialDate:
          formData.value.birthday != null && formData.value.birthday!.isNotEmpty
              ? DateTime.parse(formData.value.birthday!)
              : null,
    );
    if (result != null) {
      formData.value.birthday = DateFormat('yyyy-MM-dd').format(result);
      update(['update-form-data']);
    }
  }

  void clearFormData() {
    nameController.clear();
    enNameController.clear();

    formData.value = AddStudentFormData(
      gender: genders[0]['value'],
      genderName: genders[0]['label'],
      mobile: '',
      unionId: '',
      openId: '',
      id: '',
      avatar: '',
      classId: '',
      className: '',
      teacherId: '',
      teacherName: '',
      teacherEnName: '',
      birthday: '',
    );
    update(['update-form-data']);
  }

  Future<void> saveStudent({
    bool back = false,
  }) async {
    if (formData.value.name == null || formData.value.name!.isEmpty) {
      toastService.showError(
        message: 'toast.add_student.name_required'.tr,
      );
      nameFocusNode.requestFocus();
      return;
    }
    if (formData.value.enName == null || formData.value.enName!.isEmpty) {
      toastService.showError(
        message: 'toast.add_student.en_name_required'.tr,
      );
      enNameFocusNode.requestFocus();
      return;
    }

    NormalResponse response = await studentService.addStudent(
      name: formData.value.name!,
      enName: formData.value.enName!,
      gender: formData.value.gender!,
      mobile: formData.value.mobile ?? '',
      unionId: formData.value.unionId ?? '',
      openId: formData.value.openId ?? '',
      avatar: formData.value.avatar ?? '',
      id: formData.value.id ?? '',
      classId: formData.value.classId ?? '',
      teacherId: formData.value.teacherId ?? '',
      birthday: formData.value.birthday ?? '',
    );

    if (response.code == 200) {
      toastService.showSuccess(
        message: 'toast.add_student.save.success'.tr,
        duration: const Duration(seconds: 8),
      );

      newStudents.add(StudentEntity.fromJson(response.data));

      if (back) {
        Get.back(result: newStudents);
      } else {
        webViewController?.reload();
        clearFormData();
      }
    } else {
      toastService.showError(
        message: response.message ?? 'toast.add_student.save.fail'.tr,
      );
    }
  }
}
