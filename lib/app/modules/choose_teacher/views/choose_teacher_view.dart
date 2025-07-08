import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/choose_teacher_controller.dart';

class ChooseTeacherView extends GetView<ChooseTeacherController> {
  const ChooseTeacherView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChooseTeacherView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChooseTeacherView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
