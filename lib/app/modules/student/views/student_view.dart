import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_indicator_builder/custom_indicator_builder.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/components/empty_result/empty_result.dart';

import '../controllers/student_controller.dart';

// ignore: must_be_immutable
class StudentView extends GetView {
  String? classId;
  String? teacherId;
  StudentView({super.key, this.classId, this.teacherId}) {
    if ((classId != null && classId!.isNotEmpty) ||
        (teacherId != null && teacherId!.isNotEmpty)) {
      Get.put<StudentController>(
        StudentController(
          classId: classId ?? '',
          teacherId: teacherId ?? '',
        ),
        tag: 'student-$classId-$teacherId',
      );
    }
  }

  @override
  StudentController get controller =>
      ((classId != null && classId!.isNotEmpty) ||
              (teacherId != null && teacherId!.isNotEmpty))
          ? Get.find<StudentController>(tag: 'student-$classId-$teacherId')
          : Get.find<StudentController>();

  Widget _buildAvatar(String avatar) {
    return Container(
      width: 32,
      height: 32,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Get.theme.colorScheme.surface,
      ),
      child: CachedNetworkImage(
        imageUrl: avatar,
        placeholder: (context, url) => Container(
          width: 32,
          height: 32,
          color: Get.theme.colorScheme.surface,
          child: const Icon(Icons.error),
        ),
        errorWidget: (context, url, error) => Container(
          width: 32,
          height: 32,
          color: Get.theme.colorScheme.surface,
          child: const Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildItemData(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(left: 16, right: 16, top: index == 0 ? 8 : 4),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Get.theme.dividerColor.withValues(alpha: 0.02),
            width: index == 0 ? 0 : 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        onTap: () {
          controller.gotoStudentDetail(
            id: controller.students[index].id,
          );
        },
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
          ),
          clipBehavior: Clip.hardEdge,
          child: _buildAvatar(controller.students[index].avatar ?? ''),
        ),
        tileColor: Get.theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Row(
          spacing: 4,
          children: [
            Text(controller.students[index].name ?? ''),
            Text(
              controller.students[index].enName != null &&
                      controller.students[index].enName!.isNotEmpty
                  ? '(${controller.students[index].enName})'
                  : '',
              style: TextStyle(
                color: Get.theme.primaryColor.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
        subtitle: Row(
          spacing: 8,
          children: [
            if (controller.students[index].classInfo != null &&
                controller.students[index].classInfo!.id.isNotEmpty)
              Text(
                '${"class".tr}: ${controller.students[index].classInfo?.name ?? ''}',
                style: Get.theme.textTheme.bodySmall?.copyWith(
                  color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              )
            else
              Container(
                height: 16,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.error,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'no_class'.tr,
                  style: Get.theme.textTheme.bodySmall?.copyWith(
                    fontSize: 10,
                    color: Get.theme.colorScheme.onError,
                    height: 1.6,
                  ),
                ),
              ),
            if (controller.students[index].classInfo != null &&
                controller.students[index].classInfo!.id.isNotEmpty)
              Text(
                '${"teacher".tr}: ${controller.students[index].classInfo?.teacherName ?? ''} ${controller.students[index].classInfo?.teacherEnName != null && controller.students[index].classInfo!.teacherEnName!.isNotEmpty ? '(${controller.students[index].classInfo?.teacherEnName})' : ''}',
                style: Get.theme.textTheme.bodySmall?.copyWith(
                  color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              )
          ],
        ),
        trailing: SvgPicture.asset(
          'assets/svgs/icon_arrow_right.svg',
          width: 20,
          height: 20,
          colorFilter: ColorFilter.mode(
            Get.theme.colorScheme.onSurface.withValues(alpha: 0.18),
            BlendMode.srcIn,
          ),
        ),
        contentPadding: EdgeInsets.only(left: 16, right: 12),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (index == controller.students.length - 1) {
      return Column(
        children: [
          _buildItemData(context, index),
          Container(
            width: Get.width,
            height: 40,
            alignment: Alignment.center,
            child: Text(
              'load_more.tips.no_more'.tr,
              style: Get.theme.textTheme.bodySmall?.copyWith(
                color: Color(0xFF888888),
              ),
            ),
          ),
        ],
      );
    }
    return _buildItemData(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'student.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: const CustomBackwardView(),
        actions: [
          IconButton(
            onPressed: () {
              controller.gotoAddStudent();
            },
            icon: SvgPicture.asset(
              'assets/svgs/icon_plus.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: CustomMaterialIndicator(
        onRefresh: controller.onRefresh,
        backgroundColor: Colors.white,
        indicatorBuilder: customIndicatorBuilder,
        child: GetBuilder(
          init: controller,
          id: 'update-students',
          tag: classId != null ? 'student-$classId' : '',
          builder: (_) {
            return FutureBuilder(
              future: controller.initStudentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CustomLoader(),
                  );
                }

                if (controller.students.isEmpty) {
                  return ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: Get.height - 300,
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            EmptyResult(
                              mainButton: FilledButton(
                                onPressed: () {
                                  controller.gotoAddStudent();
                                },
                                child: Text('student.btn.add'.tr),
                              ),
                              showSecondaryButton: true,
                              secondaryButton: FilledButton(
                                onPressed: () {
                                  controller.onRefresh();
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.black45,
                                ),
                                child: Text('student.btn.reload'.tr),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverList.builder(
                      itemCount: controller.students.length,
                      itemBuilder: _buildItem,
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
