import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/app/modules/add_class/controllers/add_class_controller.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';

// ignore: must_be_immutable
class AddClassView extends GetView {
  String? teacherId;
  AddClassView({super.key, this.teacherId}) {
    if (teacherId != null && teacherId!.isNotEmpty) {
      Get.put<AddClassController>(
        AddClassController(teacherId: teacherId),
        tag: 'add-class-$teacherId',
      );
    }
  }

  @override
  AddClassController get controller => teacherId != null
      ? Get.find<AddClassController>(tag: 'add-class-$teacherId')
      : Get.find<AddClassController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add_class.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: const CustomBackwardView(),
      ),
      body: FutureBuilder(
        future: controller.initAddClassFuture,
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
                            'add_class.form_data.name'.tr,
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
                                        'add_class.form_data.name.hint'.tr,
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
                    onTap: teacherId != null && teacherId!.isNotEmpty
                        ? null
                        : () {
                            controller.chooseTeacher();
                          },
                    leading: SizedBox(
                      width: 100,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_class.form_data.teacher'.tr,
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
                                      controller.formData.value.teacherName ??
                                          'add_class.form_data.teacher.hint'.tr,
                                      style: Get.theme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: controller.formData.value
                                                    .teacherName !=
                                                null
                                            ? Get.theme.hintColor
                                            : Get.theme.disabledColor,
                                      ),
                                    ),
                                    if (teacherId == null || teacherId!.isEmpty)
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
                    tileColor: Get.theme.colorScheme.surface,
                    dense: true,
                    titleAlignment: ListTileTitleAlignment.top,
                    leading: SizedBox(
                      width: 100,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_class.form_data.icon'.tr,
                            style: Get.theme.textTheme.labelLarge?.copyWith(
                              color: Get.theme.hintColor,
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
                              child: GestureDetector(
                                onTap: () {
                                  controller.uploadClassIcon();
                                },
                                child: Container(
                                  height: 200,
                                  color: Color(0xFFF8F8F8),
                                  child: controller
                                          .classIcon.value.path.isNotEmpty
                                      ? Image.file(
                                          File(controller.classIcon.value.path),
                                          fit: BoxFit.cover,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/svgs/icon_upload.svg',
                                              width: 42,
                                              height: 42,
                                              colorFilter: ColorFilter.mode(
                                                Get.theme.disabledColor,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'add_class.form_data.icon.hint'
                                                  .tr,
                                              style: Get
                                                  .theme.textTheme.labelLarge
                                                  ?.copyWith(
                                                color: Get.theme.disabledColor,
                                              ),
                                            ),
                                          ],
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
                            controller.saveClass(back: true);
                          },
                          child: Text('add_class.form_data.btn.saveAndBack'.tr),
                        ),
                        const SizedBox(width: 16),
                        FilledButton(
                          onPressed: () {
                            controller.saveClass(back: false);
                          },
                          child: Text('add_class.form_data.btn.save'.tr),
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
