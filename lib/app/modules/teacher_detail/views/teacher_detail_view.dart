import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_indicator_builder/custom_indicator_builder.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/components/empty_result/empty_result.dart';

import '../controllers/teacher_detail_controller.dart';

class TeacherDetailView extends GetView<TeacherDetailController> {
  final String id;
  const TeacherDetailView({super.key, required this.id});

  Widget _buildAvatar({
    String? avatar,
    double? width,
    double? height,
  }) {
    if (avatar != null && avatar.isNotEmpty) {
      return Container(
        width: width ?? Get.width,
        height: height ?? 230,
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        child: CachedNetworkImage(
          imageUrl: controller.teacher.value.avatar!,
          width: Get.width,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      width: width ?? Get.width,
      height: height ?? 230,
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/profile_bg.jpeg',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );

    return Obx(
      () => avatar != null && avatar.isNotEmpty
          ? Container(
              width: width ?? Get.width,
              height: height ?? 230,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: controller.teacher.value.avatar!,
                width: Get.width,
                fit: BoxFit.cover,
              ),
            )
          : Container(
              width: width ?? Get.width,
              height: height ?? 230,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/profile_bg.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomMaterialIndicator(
        onRefresh: controller.onRefresh,
        backgroundColor: Colors.white,
        indicatorBuilder: customIndicatorBuilder,
        child: GetBuilder(
          init: controller,
          id: 'update-student-detail',
          builder: (_) {
            return FutureBuilder(
              future: controller.initTeacherDetailFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CustomLoader(),
                  );
                }
                if (controller.teacher.value.id.isEmpty) {
                  return ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        width: Get.width,
                        height: Get.height - 300,
                        child: Flex(
                          direction: Axis.vertical,
                          children: [
                            EmptyResult(),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return Stack(
                  children: [
                    SizedBox(
                      width: Get.width,
                      height: 230,
                      child: _buildAvatar(
                        avatar: controller.teacher.value.avatar,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter:
                            ImageFilter.blur(sigmaX: 6, sigmaY: 6), // 设置模糊程度
                        child: Container(
                          color: Colors.white.withAlpha(0), // 透明背景
                        ),
                      ),
                    ),
                    Positioned(
                      child: CustomScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 200,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              width: Get.width,
                              height: 64,
                              margin: EdgeInsets.only(
                                left: 24,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 64,
                                    height: 64,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                    child: _buildAvatar(
                                      avatar: controller.teacher.value.avatar,
                                      width: 64,
                                      height: 64,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 12,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ListTile(
                              subtitle: Text('teacher_detail.group.base'.tr),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              elevation: 0,
                              child: ListTile(
                                tileColor:
                                    Get.theme.hintColor.withValues(alpha: 0.03),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/svgs/icon_category.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text("teacher_detail.label.name".tr),
                                trailing: Text(
                                  "${controller.teacher.value.name ?? ''} (${controller.teacher.value.enName ?? ''})",
                                  style:
                                      Get.theme.textTheme.bodyMedium?.copyWith(
                                    color: Get.theme.hintColor
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Divider(
                              color: Get.theme.dividerColor
                                  .withValues(alpha: 0.06),
                              thickness: 1,
                              height: 1,
                              indent: 24,
                              endIndent: 24,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              elevation: 0,
                              child: ListTile(
                                tileColor:
                                    Get.theme.hintColor.withValues(alpha: 0.03),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/svgs/icon_call.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text("teacher_detail.label.mobile".tr),
                                trailing: Text(
                                  controller.teacher.value.mobile ?? '',
                                  style:
                                      Get.theme.textTheme.bodyMedium?.copyWith(
                                    color: Get.theme.hintColor
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Divider(
                              color: Get.theme.dividerColor
                                  .withValues(alpha: 0.06),
                              thickness: 1,
                              height: 1,
                              indent: 24,
                              endIndent: 24,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              elevation: 0,
                              child: ListTile(
                                tileColor:
                                    Get.theme.hintColor.withValues(alpha: 0.03),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/svgs/tab_schedule_unselected.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text("teacher_detail.label.is_admin".tr),
                                trailing: Text(
                                  controller.teacher.value.admin == '1'
                                      ? 'teacher_detail.label.is_admin.true'.tr
                                      : 'teacher_detail.label.is_admin.false'
                                          .tr,
                                  style:
                                      Get.theme.textTheme.bodyMedium?.copyWith(
                                    color: Get.theme.hintColor
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Divider(
                              color: Get.theme.dividerColor
                                  .withValues(alpha: 0.06),
                              thickness: 1,
                              height: 1,
                              indent: 24,
                              endIndent: 24,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              elevation: 0,
                              child: ListTile(
                                tileColor:
                                    Get.theme.hintColor.withValues(alpha: 0.03),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/svgs/tab_schedule_unselected.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text("teacher_detail.label.type".tr),
                                trailing: Text(
                                  'teacher_detail.label.type.${controller.teacher.value.type}'
                                      .tr,
                                  style:
                                      Get.theme.textTheme.bodyMedium?.copyWith(
                                    color: Get.theme.hintColor
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ListTile(
                              subtitle: Row(
                                spacing: 8,
                                children: [
                                  Text('teacher_detail.group.class'.tr),
                                  // Container(
                                  //   width: 24,
                                  //   height: 24,
                                  //   alignment: Alignment.center,
                                  //   child: SvgPicture.asset(
                                  //     'assets/svgs/icon_edit.svg',
                                  //     width: 20,
                                  //     height: 20,
                                  //     colorFilter: ColorFilter.mode(
                                  //       Get.theme.colorScheme.primary,
                                  //       BlendMode.srcIn,
                                  //     ),
                                  //   ),
                                  // )
                                ],
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              elevation: 0,
                              child: ListTile(
                                tileColor:
                                    Get.theme.hintColor.withValues(alpha: 0.03),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/svgs/tab_class_unselected.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text("teacher_detail.label.class".tr),
                                // trailing: Text(
                                //   controller.teacher.value.classInfo?.name ??
                                //       '',
                                //   style:
                                //       Get.theme.textTheme.bodyMedium?.copyWith(
                                //     color: Get.theme.hintColor
                                //         .withValues(alpha: 0.5),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ListTile(
                              subtitle: Text('teacher_detail.group.student'.tr),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              elevation: 0,
                              child: ListTile(
                                tileColor:
                                    Get.theme.hintColor.withValues(alpha: 0.03),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/svgs/icon_bag.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text("teacher_detail.label.student".tr),
                                // trailing: Text(
                                //   '${controller.student.value.totalSessions ?? 0}',
                                //   style:
                                //       Get.theme.textTheme.bodyMedium?.copyWith(
                                //     color: Get.theme.hintColor
                                //         .withValues(alpha: 0.5),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: ListTile(
                              subtitle:
                                  Text('teacher_detail.group.sessions'.tr),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 0,
                              ),
                              elevation: 0,
                              child: ListTile(
                                tileColor:
                                    Get.theme.hintColor.withValues(alpha: 0.03),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                leading: SvgPicture.asset(
                                  'assets/svgs/icon_bag.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text("teacher_detail.label.sessions".tr),
                                // trailing: Text(
                                //   '${controller.student.value.totalSessions ?? 0}',
                                //   style:
                                //       Get.theme.textTheme.bodyMedium?.copyWith(
                                //     color: Get.theme.hintColor
                                //         .withValues(alpha: 0.5),
                                //   ),
                                // ),
                              ),
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 48,
                            ),
                          ),
                        ],
                      ),
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
