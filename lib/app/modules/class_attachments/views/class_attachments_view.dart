import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/class_attachments_controller.dart';

class ClassAttachmentsView extends GetView<ClassAttachmentsController> {
  final String classId;
  const ClassAttachmentsView({
    super.key,
    required this.classId,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClassAttachmentsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ClassAttachmentsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
