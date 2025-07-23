import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/app/modules/class/controllers/class_controller.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_indicator_builder/custom_indicator_builder.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/components/empty_result/empty_result.dart';
import 'package:wingapp/components/need_login/need_login.dart';

// ignore: must_be_immutable
class ClassView extends GetView {
  String? teacherId;
  ClassView({super.key, this.teacherId}) {
    if (teacherId != null && teacherId!.isNotEmpty) {
      Get.put<ClassController>(
        ClassController(teacherId: teacherId),
        tag: 'class-${teacherId ?? ''}',
      );
    }
  }

  @override
  ClassController get controller => teacherId != null
      ? Get.find<ClassController>(tag: 'class-${teacherId ?? ''}')
      : Get.find<ClassController>();

  Widget _buildItemData(BuildContext context, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Get.theme.dividerColor.withValues(alpha: 0.02),
            width: index == 0 ? 0 : 1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        onTap: () {
          controller.gotoClassDetail(classId: controller.classes[index].id);
        },
        tileColor: Get.theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        leading: controller.classes[index].icon != null &&
                controller.classes[index].icon!.isNotEmpty
            ? Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.hardEdge,
                child: CachedNetworkImage(
                  imageUrl: controller.classes[index].icon!,
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) {
                    return SvgPicture.asset(
                      'assets/svgs/tab_student_selected.svg',
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
        title: Text(controller.classes[index].name ?? ''),
        subtitle: Text(
          '${'teacher'.tr}: ${controller.classes[index].teacherName ?? ''} (${controller.classes[index].teacherEnName ?? ''})',
          style: Get.theme.textTheme.bodySmall?.copyWith(
            color: Color(0xFF888888),
          ),
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
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    // if (controller.totalCount.value == 0) {
    //   return SizedBox(
    //     width: Get.width,
    //     height: Get.height - 300,
    //     child: EmptyResult(
    //       onPressed: () {
    //         controller.gotoAddClass();
    //       },
    //     ),
    //   );
    // }
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
          'class.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: const CustomBackwardView(),
        actions: [
          IconButton(
            onPressed: () {
              controller.gotoAddClass();
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
        onRefresh: () async {
          await controller.onRefresh();
        },
        indicatorBuilder: customIndicatorBuilder,
        child: GetBuilder(
          id: 'update-classes',
          init: controller,
          builder: (_) {
            return FutureBuilder(
              future: controller.initClassesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CustomLoader(),
                  );
                }
                if (controller.loginInfo.value == null) {
                  return SizedBox(
                    width: Get.width,
                    height: Get.height - 300,
                    child: Flex(
                      direction: Axis.vertical,
                      children: [
                        NeedLogin(
                          onPressed: () {
                            controller.needLogin();
                          },
                        ),
                      ],
                    ),
                  );
                }
                if (controller.classes.isEmpty) {
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
                                  controller.gotoAddClass();
                                },
                                child: Text('class.btn.add'.tr),
                              ),
                              showSecondaryButton: true,
                              secondaryButton: FilledButton(
                                onPressed: () {
                                  controller.getClasses();
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor:
                                      Get.theme.colorScheme.secondary,
                                ),
                                child: Text('class.btn.reload'.tr),
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
                      itemCount: controller.classes.length,
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
