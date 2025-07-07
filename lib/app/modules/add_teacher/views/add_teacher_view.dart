import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';

import '../controllers/add_teacher_controller.dart';

class AddTeacherView extends GetView<AddTeacherController> {
  const AddTeacherView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add_teacher.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: const CustomBackwardView(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              ListTile(
                tileColor: Colors.white,
                dense: true,
                leading: SizedBox(
                  width: 64,
                  height: 48,
                  child: Row(
                    children: [
                      Text(
                        'add_teacher.form_data.name'.tr,
                        style: Get.theme.textTheme.labelLarge?.copyWith(
                          color: Get.theme.hintColor,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '*',
                        style: Get.theme.textTheme.labelLarge?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder(
                      id: 'update-name',
                      init: controller,
                      builder: (_) {
                        return Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              controller: controller.nameController,
                              focusNode: controller.nameFocusNode,
                              onTapOutside: (value) {
                                controller.nameFocusNode.unfocus();
                              },
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 10,
                                ),
                                border: InputBorder.none,
                                hintText: 'add_teacher.form_data.name.hint'.tr,
                                hintStyle:
                                    Get.theme.textTheme.titleMedium?.copyWith(
                                  color: Get.theme.disabledColor,
                                ),
                                suffixIcon:
                                    controller.formData.value.name != null &&
                                            controller
                                                .formData.value.name!.isNotEmpty
                                        ? GestureDetector(
                                            onTap: () {
                                              // controller.clearUsername();
                                            },
                                            child: const SizedBox(
                                              width: 36,
                                              height: 36,
                                              child: Icon(
                                                Icons.clear_outlined,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                visualDensity: VisualDensity.compact,
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(alpha: 0.02),
              ),
              ListTile(
                tileColor: Colors.white,
                dense: true,
                leading: SizedBox(
                  width: 64,
                  height: 48,
                  child: Row(
                    children: [
                      Text(
                        'add_teacher.form_data.en_name'.tr,
                        style: Get.theme.textTheme.labelLarge?.copyWith(
                          color: Get.theme.hintColor,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        '*',
                        style: Get.theme.textTheme.labelLarge?.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder(
                      id: 'update-enName',
                      init: controller,
                      builder: (_) {
                        return Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextFormField(
                              controller: controller.enNameController,
                              focusNode: controller.enNameFocusNode,
                              onTapOutside: (value) {
                                controller.enNameFocusNode.unfocus();
                              },
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.url,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 0,
                                  vertical: 10,
                                ),
                                border: InputBorder.none,
                                hintText:
                                    'add_teacher.form_data.en_name.hint'.tr,
                                hintStyle:
                                    Get.theme.textTheme.titleMedium?.copyWith(
                                  color: Get.theme.disabledColor,
                                ),
                                suffixIcon:
                                    controller.formData.value.enName != null &&
                                            controller.formData.value.enName!
                                                .isNotEmpty
                                        ? GestureDetector(
                                            onTap: () {
                                              // controller.clearUsername();
                                            },
                                            child: const SizedBox(
                                              width: 36,
                                              height: 36,
                                              child: Icon(
                                                Icons.clear_outlined,
                                                size: 16,
                                                color: Colors.red,
                                              ),
                                            ),
                                          )
                                        : null,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                visualDensity: VisualDensity.compact,
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(alpha: 0.02),
              ),
              ListTile(
                tileColor: Colors.white,
                dense: true,
                onTap: () {
                  controller.chooseGender();
                },
                leading: SizedBox(
                  width: 64,
                  height: 48,
                  child: Row(
                    children: [
                      Text(
                        'add_teacher.form_data.gender'.tr,
                        style: Get.theme.textTheme.labelLarge?.copyWith(
                          color: Get.theme.hintColor,
                        ),
                      ),
                      // const SizedBox(
                      //   width: 4,
                      // ),
                      // Text(
                      //   '*',
                      //   style: Get.theme.textTheme.labelLarge?.copyWith(
                      //     color: Colors.red,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder(
                      id: 'update-gender',
                      init: controller,
                      builder: (_) {
                        return Expanded(
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.formData.value.genderName ??
                                      'add_teacher.form_data.gender.hint'.tr,
                                  style:
                                      Get.theme.textTheme.titleMedium?.copyWith(
                                    color:
                                        controller.formData.value.genderName !=
                                                null
                                            ? Get.theme.hintColor
                                            : Get.theme.disabledColor,
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/svgs/icon_arrow_right.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                visualDensity: VisualDensity.compact,
              ),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withValues(alpha: 0.02),
              ),
              ListTile(
                tileColor: Colors.white,
                dense: true,
                onTap: () {
                  controller.chooseTeacherType();
                },
                leading: SizedBox(
                  width: 64,
                  height: 48,
                  child: Row(
                    children: [
                      Text(
                        'add_teacher.form_data.type'.tr,
                        style: Get.theme.textTheme.labelLarge?.copyWith(
                          color: Get.theme.hintColor,
                        ),
                      ),
                      // const SizedBox(
                      //   width: 4,
                      // ),
                      // Text(
                      //   '*',
                      //   style: Get.theme.textTheme.labelLarge?.copyWith(
                      //     color: Colors.red,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                title: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder(
                      id: 'update-type',
                      init: controller,
                      builder: (_) {
                        return Expanded(
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.formData.value.typeName ??
                                      'add_teacher.form_data.type.hint'.tr,
                                  style:
                                      Get.theme.textTheme.titleMedium?.copyWith(
                                    color: controller.formData.value.typeName !=
                                            null
                                        ? Get.theme.hintColor
                                        : Get.theme.disabledColor,
                                  ),
                                ),
                                SvgPicture.asset(
                                  'assets/svgs/icon_arrow_right.svg',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                visualDensity: VisualDensity.compact,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
