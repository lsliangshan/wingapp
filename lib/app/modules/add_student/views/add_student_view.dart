import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';

import '../controllers/add_student_controller.dart';

class AddStudentView extends GetView<AddStudentController> {
  const AddStudentView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add_student.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: const CustomBackwardView(),
      ),
      body: FutureBuilder(
        future: controller.initAddStudentFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CustomLoader(),
            );
          }

          return SingleChildScrollView(
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
                      width: 100,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_student.form_data.name'.tr,
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
                          id: 'update-form-data',
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
                                    hintText:
                                        'add_student.form_data.name.hint'.tr,
                                    hintStyle: Get.theme.textTheme.titleMedium
                                        ?.copyWith(
                                      color: Get.theme.disabledColor,
                                    ),
                                    suffixIcon:
                                        controller.formData.value.name !=
                                                    null &&
                                                controller.formData.value.name!
                                                    .isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller.clearName();
                                                },
                                                child: const SizedBox(
                                                  width: 36,
                                                  height: 36,
                                                  child: Icon(
                                                    Icons.clear_outlined,
                                                    size: 20,
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
                      width: 100,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_student.form_data.en_name'.tr,
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
                          id: 'update-form-data',
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
                                        'add_student.form_data.en_name.hint'.tr,
                                    hintStyle: Get.theme.textTheme.titleMedium
                                        ?.copyWith(
                                      color: Get.theme.disabledColor,
                                    ),
                                    suffixIcon:
                                        controller.formData.value.enName !=
                                                    null &&
                                                controller.formData.value
                                                    .enName!.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller.clearEnName();
                                                },
                                                child: const SizedBox(
                                                  width: 36,
                                                  height: 36,
                                                  child: Icon(
                                                    Icons.clear_outlined,
                                                    size: 20,
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
                      controller.chooseClass();
                    },
                    leading: SizedBox(
                      width: 100,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_student.form_data.class'.tr,
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
                          id: 'update-form-data',
                          init: controller,
                          builder: (_) {
                            return Expanded(
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.formData.value.className !=
                                                  null &&
                                              controller.formData.value
                                                  .className!.isNotEmpty
                                          ? controller.formData.value.className!
                                          : 'add_student.form_data.class.hint'
                                              .tr,
                                      style: Get.theme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: controller.formData.value
                                                        .className !=
                                                    null &&
                                                controller.formData.value
                                                    .className!.isNotEmpty
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
                      controller.chooseGender();
                    },
                    leading: SizedBox(
                      width: 100,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_student.form_data.gender'.tr,
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
                          id: 'update-form-data',
                          init: controller,
                          builder: (_) {
                            return Expanded(
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.formData.value.genderName !=
                                                  null &&
                                              controller.formData.value
                                                  .genderName!.isNotEmpty
                                          ? controller
                                              .formData.value.genderName!
                                          : 'add_student.form_data.gender.hint'
                                              .tr,
                                      style: Get.theme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: controller.formData.value
                                                        .genderName !=
                                                    null &&
                                                controller.formData.value
                                                    .genderName!.isNotEmpty
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
                      controller.setBirthday();
                    },
                    leading: SizedBox(
                      width: 100,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_student.form_data.birthday'.tr,
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
                          id: 'update-form-data',
                          init: controller,
                          builder: (_) {
                            return Expanded(
                              child: SizedBox(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.formData.value.birthday !=
                                                  null &&
                                              controller.formData.value
                                                  .birthday!.isNotEmpty
                                          ? controller.formData.value.birthday!
                                          : 'add_student.form_data.birthday.hint'
                                              .tr,
                                      style: Get.theme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: controller.formData.value
                                                        .birthday !=
                                                    null &&
                                                controller.formData.value
                                                    .birthday!.isNotEmpty
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
                    titleAlignment: ListTileTitleAlignment.top,
                    leading: SizedBox(
                      width: 100,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_student.form_data.dingtalk.login'.tr,
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
                    title: SizedBox(
                      height: 200,
                      child: InAppWebView(
                        // key: UniqueKey(),
                        initialUrlRequest: URLRequest(
                            url: WebUri(
                                'https://wing.liangqy.com/dingtalk/login')),
                        // initialUrlRequest: URLRequest(url: WebUri('http://127.0.0.1:5173')),
                        initialSettings: InAppWebViewSettings(
                          javaScriptEnabled: true,
                          transparentBackground: true,
                        ),
                        onWebViewCreated: controller.onWebViewCreated,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    visualDensity: VisualDensity.compact,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: Get.width,
                    height: 48,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            controller.saveStudent(back: true);
                          },
                          child:
                              Text('add_student.form_data.btn.saveAndBack'.tr),
                        ),
                        const SizedBox(width: 16),
                        FilledButton(
                          onPressed: () {
                            controller.saveStudent(back: false);
                          },
                          child: Text('add_student.form_data.btn.save'.tr),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
