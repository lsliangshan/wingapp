import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_class_controller.dart';

class AddClassView extends GetView<AddClassController> {
  const AddClassView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddClassView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddClassView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
