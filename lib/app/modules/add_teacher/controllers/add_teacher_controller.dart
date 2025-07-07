import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/data/app.config.dart';

class AddTeacherFormData {
  String? name;
  String? enName;
  String? gender;
  String? genderName;
  String? type;
  String? typeName;

  AddTeacherFormData({
    this.name,
    this.enName,
    this.gender,
    this.genderName,
    this.type,
    this.typeName,
  });
}

class AddTeacherController extends GetxController {
  final formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController enNameController = TextEditingController();

  FocusNode nameFocusNode = FocusNode();
  FocusNode enNameFocusNode = FocusNode();

  Rx<AddTeacherFormData> formData = AddTeacherFormData(
    gender: genders[0]['value'],
    genderName: genders[0]['label'],
    type: teacherTypes[0]['value'],
    typeName: teacherTypes[0]['label'],
  ).obs;

  @override
  void onInit() {
    super.onInit();
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
                        update(['update-gender']);
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
                        update(['update-type']);
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
}
