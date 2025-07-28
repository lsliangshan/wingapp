import 'package:flutter/material.dart';

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
                    leading: SizedBox(
                      width: 100,
                      height: 48,
                      child: Row(
                        children: [
                          Text(
                            'add_schedule.form_data.name'.tr,
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
                                        'add_schedule.form_data.name.hint'.tr,
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
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
