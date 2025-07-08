import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/empty_result/empty_result.dart';

import '../controllers/teacher_controller.dart';

class TeacherView extends GetView<TeacherController> {
  const TeacherView({super.key});

  Widget _buildItemData(BuildContext context, int index) {
    return ListTile(
      onTap: () {},
      leading: controller.teachers[index].avatar != null &&
              controller.teachers[index].avatar!.isNotEmpty
          ? Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              clipBehavior: Clip.hardEdge,
              child: CachedNetworkImage(
                imageUrl: controller.teachers[index].avatar!,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) {
                  return SvgPicture.asset(
                    'assets/svgs/tab_profile_selected.svg',
                    width: 32,
                    height: 32,
                  );
                },
              ),
            )
          : Container(
              width: 40,
              height: 40,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Get.theme.colorScheme.surface,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/svgs/tab_profile_selected.svg',
                width: 32,
                height: 32,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF888888),
                  BlendMode.srcIn,
                ),
              ),
            ),
      title: Text(controller.teachers[index].name ??
          controller.teachers[index].enName ??
          ''),
      subtitle: Text(
        controller.teachers[index].mobile,
        style: Get.theme.textTheme.bodySmall?.copyWith(
          color: Color(0xFF888888),
        ),
      ),
      trailing: SvgPicture.asset(
        'assets/svgs/icon_arrow_right.svg',
        width: 20,
        height: 20,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (controller.totalCount.value == 0) {
      return SizedBox(
        width: Get.width,
        height: Get.height - 300,
        child: EmptyResult(
          onPressed: () {
            controller.gotoAddTeacher();
          },
        ),
      );
    }
    if (controller.totalPage.value == controller.pageIndex.value &&
        index == controller.totalCount.value - 1) {
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
          'teacher.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: const CustomBackwardView(),
        actions: [
          IconButton(
            onPressed: () {
              controller.gotoAddTeacher();
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
      body: GetBuilder(
        id: 'update-teachers',
        init: controller,
        builder: (_) {
          return CustomScrollView(
            slivers: [
              SliverList.builder(
                itemCount: controller.teachers.length,
                itemBuilder: _buildItem,
              ),
            ],
          );
        },
      ),
    );
  }
}
