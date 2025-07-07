import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
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
                  width: 100,
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
                  width: 100,
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
                  width: 100,
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
                  width: 100,
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
                        'add_teacher.form_data.dingtalk.login'.tr,
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
                      id: 'update-dingtalk-login',
                      init: controller,
                      builder: (_) {
                        return Expanded(
                          child: Container(
                            color: Colors.black12,
                            height: 200,
                            child: InAppWebView(
                              // key: UniqueKey(),
                              initialUrlRequest: URLRequest(
                                  url: WebUri(
                                      'http://10.2.6.210:5173/dingtalk/login')),
                              // initialUrlRequest: URLRequest(url: WebUri('http://127.0.0.1:5173')),
                              initialSettings: InAppWebViewSettings(
                                javaScriptEnabled: true,
                                transparentBackground: true,
                              ),
                              onWebViewCreated: controller.onWebViewCreated,
                              onLoadStop: (ctrl, url) async {
                                // await Future.delayed(Duration(milliseconds: 100));
                                // await ctrl.evaluateJavascript(source: controller.initDataStr);
                              },
                              onConsoleMessage: (controller, consoleMessage) {
                                print(
                                    '>>>>> consoleMessage: ${consoleMessage.message}');
                                // it will print: {message: {"foo":1,"bar":false}, messageLevel: 1}
                              },
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
                        controller.saveTeacher(back: true);
                      },
                      child: Text('add_teacher.form_data.btn.saveAndBack'.tr),
                    ),
                    const SizedBox(width: 16),
                    FilledButton(
                      onPressed: () {
                        controller.saveTeacher(back: false);
                      },
                      child: Text('add_teacher.form_data.btn.save'.tr),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
