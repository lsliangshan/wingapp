import 'package:flutter/material.dart';

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
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: const CustomBackwardView(),
      ),
      body: const Center(
        child: Text(
          'AddTeacherView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
