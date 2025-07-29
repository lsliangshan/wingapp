import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';

import '../controllers/add_schedule_controller.dart';

class AddScheduleView extends GetView<AddScheduleController> {
  const AddScheduleView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'add_schedule.title'.tr,
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
                    onTap: () {
                      controller.chooseClass();
                    },
                    leading: SizedBox(
                      width: 80,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_schedule.form_data.class'.tr,
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
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      controller.formData.value.className,
                                      style: Get.theme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: controller.formData.value
                                                .className.isNotEmpty
                                            ? Get.theme.hintColor
                                            : Get.theme.disabledColor,
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/svgs/icon_arrow_right.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: ColorFilter.mode(
                                        Get.theme.colorScheme.onSurface
                                            .withValues(alpha: 0.18),
                                        BlendMode.srcIn,
                                      ),
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
                    height: 0.5,
                    color: Get.theme.dividerColor.withValues(alpha: 0.02),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'add_schedule.form_data.title'.tr,
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
                  Container(
                    color: Colors.white,
                    child: GetBuilder(
                      id: 'update-form-data',
                      init: controller,
                      builder: (_) {
                        return TextFormField(
                          controller: controller.titleController,
                          focusNode: controller.titleFocusNode,
                          onTapOutside: (value) {
                            controller.titleFocusNode.unfocus();
                          },
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                            hintText: 'add_schedule.form_data.title.hint'.tr,
                            hintStyle:
                                Get.theme.textTheme.titleMedium?.copyWith(
                              color: Get.theme.disabledColor,
                            ),
                            suffixIcon:
                                controller.formData.value.title.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.clearTitle();
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
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    color: Get.theme.dividerColor.withValues(alpha: 0.02),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 0,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'add_schedule.form_data.content'.tr,
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
                  Container(
                    color: Colors.white,
                    child: GetBuilder(
                      id: 'update-form-data',
                      init: controller,
                      builder: (_) {
                        return TextFormField(
                          controller: controller.contentController,
                          focusNode: controller.contentFocusNode,
                          onTapOutside: (value) {
                            controller.contentFocusNode.unfocus();
                          },
                          maxLines: 6,
                          minLines: 6,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            border: InputBorder.none,
                            hintText: 'add_schedule.form_data.content.hint'.tr,
                            hintStyle:
                                Get.theme.textTheme.titleMedium?.copyWith(
                              color: Get.theme.disabledColor,
                            ),
                            suffixIcon:
                                controller.formData.value.content.isNotEmpty
                                    ? GestureDetector(
                                        onTap: () {
                                          controller.clearContent();
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
                        );
                      },
                    ),
                  ),
                  Divider(
                    height: 0.5,
                    color: Get.theme.dividerColor.withValues(alpha: 0.02),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 16,
                      bottom: 12,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'add_schedule.form_data.time'.tr,
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
                  Container(
                    color: Colors.white,
                    height: 40,
                    padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      spacing: 4,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          color: Colors.lightBlue,
                        ),
                        Container(
                          width: 100,
                          height: 40,
                          color: Colors.lightBlue,
                        ),
                        Expanded(
                          child: Container(
                            width: 100,
                            height: 40,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 16,
                    color: Colors.white,
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
