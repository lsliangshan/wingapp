import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/models/normal_response.model.dart';
import 'package:wingapp/services/teacher.dart';
import 'package:wingapp/services/toast.dart';

class AddTeacherFormData {
  String? name;
  String? enName;
  String? gender;
  String? genderName;
  String? type;
  String? typeName;
  String? id;
  String? avatar;
  String? mobile;
  String? unionId;
  String? openId;

  AddTeacherFormData({
    this.name,
    this.enName,
    this.gender,
    this.genderName,
    this.type,
    this.typeName,
    this.id,
    this.avatar,
    this.mobile,
    this.unionId,
    this.openId,
  });

  // 将 Model 转换为 JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'enName': enName,
      'gender': gender,
      'genderName': genderName,
      'type': type,
      'typeName': typeName,
      'id': id,
      'avatar': avatar,
      'mobile': mobile,
      'unionId': unionId,
      'openId': openId,
    };
  }
}

class AddTeacherController extends GetxController {
  ToastService toastService = Get.find<ToastService>();
  TeacherService teacherService = Get.find<TeacherService>();

  final formKey = GlobalKey<FormState>();

  InAppWebViewController? webViewController;

  TextEditingController nameController = TextEditingController();
  TextEditingController enNameController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode enNameFocusNode = FocusNode();

  Rx<AddTeacherFormData> formData = AddTeacherFormData(
    gender: genders[0]['value'],
    genderName: genders[0]['label'],
    type: teacherTypes[0]['value'],
    typeName: teacherTypes[0]['label'],
    mobile: '18311032722',
    unionId: 'ONPkBJmOOeQii1n1v9BGAngiEiE',
    openId: 'hVhMdM4QLofJRgNOBXzziPQiEiE',
    avatar: '',
    id: 'ONPkBJmOOeQii1n1v9BGAngiEiE',
  ).obs;

  List<Teacher> newTeachers = [];

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

  void chooseTeacherType() {
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
                title: Text('bottom_sheet.choose_type.title'.tr),
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
                  itemCount: teacherTypes.length,
                  itemExtent: 48,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(teacherTypes[index]['label'] ?? ''),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 24),
                      trailing:
                          formData.value.type == teacherTypes[index]['value']
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
                        formData.value.type = teacherTypes[index]['value'];
                        formData.value.typeName = teacherTypes[index]['label'];
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

  void clearFormData() {
    nameController.clear();
    enNameController.clear();

    formData.value = AddTeacherFormData(
      gender: genders[0]['value'],
      genderName: genders[0]['label'],
      type: teacherTypes[0]['value'],
      typeName: teacherTypes[0]['label'],
      mobile: '',
      unionId: '',
      openId: '',
      id: '',
      avatar: '',
    );
    update(['update-form-data']);
  }

  Future<void> saveTeacher({
    bool back = false,
  }) async {
    if (formData.value.name == null || formData.value.name!.isEmpty) {
      toastService.showError(
        message: 'toast.add_teacher.name_required'.tr,
      );
      nameFocusNode.requestFocus();
      return;
    }
    if (formData.value.enName == null || formData.value.enName!.isEmpty) {
      toastService.showError(
        message: 'toast.add_teacher.en_name_required'.tr,
      );
      enNameFocusNode.requestFocus();
      return;
    }

    NormalResponse response = await teacherService.addTeacher(
      name: formData.value.name!,
      enName: formData.value.enName!,
      gender: formData.value.gender!,
      type: formData.value.type!,
      mobile: formData.value.mobile ?? '',
      unionId: formData.value.unionId ?? '',
      openId: formData.value.openId ?? '',
      avatar: formData.value.avatar ?? '',
      id: formData.value.id ?? '',
    );

    if (response.code == 200) {
      toastService.showSuccess(
        message: 'toast.add_teacher.save.success'.tr,
      );

      newTeachers.add(Teacher.fromJson(formData.value.toJson()));

      if (back) {
        Get.back(result: newTeachers);
      } else {
        webViewController?.reload();
        clearFormData();
      }
    } else {
      toastService.showError(
        message: 'toast.add_teacher.save.fail'.tr,
      );
    }
  }
}
