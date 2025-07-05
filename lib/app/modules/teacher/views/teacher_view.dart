import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';

import '../controllers/teacher_controller.dart';

class TeacherView extends GetView<TeacherController> {
  const TeacherView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'page.teacher.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: const CustomBackwardView(),
      ),
      body: const Center(
        child: Text(
          'TeacherView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
