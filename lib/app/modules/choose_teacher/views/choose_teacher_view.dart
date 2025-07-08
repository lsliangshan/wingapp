import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/empty_result/empty_result.dart';

import '../controllers/choose_teacher_controller.dart';

class ChooseTeacherView extends GetView<ChooseTeacherController> {
  const ChooseTeacherView({super.key});

  Widget _buildItemData(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        top: index == 0 ? 8 : 8,
        bottom: 0,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Get.theme.dividerColor.withValues(alpha: 0.02),
            width: index == 0 ? 0 : 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: ListTile(
        onTap: () {
          controller.chooseTeacher(controller.teachers[index]);
        },
        tileColor: Get.theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
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
        // trailing: SvgPicture.asset(
        //   'assets/svgs/icon_arrow_right.svg',
        //   width: 20,
        //   height: 20,
        // ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    if (controller.totalCount.value == 0) {
      return SizedBox(
        width: Get.width,
        height: Get.height - 300,
        child: EmptyResult(),
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
          'choose_teacher.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        leading: const CustomBackwardView(),
      ),
      body: CustomMaterialIndicator(
        onRefresh: controller.onRefresh,
        backgroundColor: Colors.white,
        indicatorBuilder: (context, controller) {
          return Stack(
            children: [
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(40),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: 10, sigmaY: 10), // 设置模糊程度
                      child: Container(
                        color: Colors.white.withAlpha(0), // 透明背景
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: CircularProgressIndicator(
                  color: Get.theme.primaryColor,
                  strokeWidth: 2,
                  value: controller.state.isLoading
                      ? null
                      : min(controller.value, 1.0),
                ),
              )
            ],
          );
        },
        child: GetBuilder(
          id: 'update-teachers',
          init: controller,
          builder: (_) {
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: controller.teachers.length,
                  itemBuilder: _buildItem,
                  // separatorBuilder: (BuildContext context, int index) {
                  //   return Divider(
                  //     height: 1,
                  //     color: Get.theme.dividerColor.withValues(alpha: 0.02),
                  //   );
                  // },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
