import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_indicator_builder/custom_indicator_builder.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/components/empty_result/empty_result.dart';

import '../controllers/student_detail_controller.dart';

class StudentDetailView extends GetView<StudentDetailController> {
  final String id;
  const StudentDetailView({super.key, required this.id});

  Widget _buildAvatar({
    required String avatar,
    double? width,
    double? height,
  }) {
    return Obx(
      () => controller.student.value.avatar != null &&
              controller.student.value.avatar!.isNotEmpty
          ? Container(
              width: width ?? Get.width,
              height: height ?? 230,
              padding: EdgeInsets.zero,
              alignment: Alignment.center,
              child: CachedNetworkImage(
                imageUrl: controller.student.value.avatar!,
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
              future: controller.initStudentDetailFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CustomLoader(),
                  );
                }
                if (controller.student.value.id.isEmpty) {
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
                    Container(
                      width: Get.width,
                      height: 230,
                      child: _buildAvatar(
                        avatar: controller.student.value.avatar!,
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
                          // SliverAppBar(
                          //   backgroundColor: Colors.transparent,
                          //   leading: CustomBackwardView(
                          //     color: Colors.black,
                          //     size: 24,
                          //   ),
                          // ),
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
                                      avatar: controller.student.value.avatar!,
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
                              subtitle: Text('student_detail.group.base'.tr),
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
                                title: Text("student_detail.label.name".tr),
                                trailing: Text(
                                  "${controller.student.value.name ?? ''} (${controller.student.value.enName ?? ''})",
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
                                title: Text("student_detail.label.mobile".tr),
                                trailing: Text(
                                  controller.student.value.mobile ?? '',
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
                                title: Text("student_detail.label.birthday".tr),
                                trailing: Text(
                                  controller.student.value.birthday
                                          ?.split(' ')
                                          .first ??
                                      '',
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
                              onTap: () {
                                controller.gotoChooseClass();
                              },
                              subtitle: Row(
                                spacing: 8,
                                children: [
                                  Text('student_detail.group.class'.tr),
                                  Container(
                                    width: 24,
                                    height: 24,
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      'assets/svgs/icon_edit.svg',
                                      width: 20,
                                      height: 20,
                                      colorFilter: ColorFilter.mode(
                                        Get.theme.colorScheme.primary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  )
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
                                title: Text("student_detail.label.class".tr),
                                trailing: Text(
                                  controller.student.value.classInfo?.name ??
                                      '',
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
                                  'assets/svgs/tab_profile_unselected.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text("student_detail.label.teacher".tr),
                                trailing: Text(
                                  '${controller.student.value.classInfo?.teacherName ?? ""} (${controller.student.value.classInfo?.teacherEnName ?? ''})',
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
                              subtitle:
                                  Text('student_detail.group.sessions'.tr),
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
                                title: Text(
                                    "student_detail.label.total_sessions".tr),
                                trailing: Text(
                                  '${controller.student.value.totalSessions ?? 0}',
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
                                  'assets/svgs/icon_bag_2.svg',
                                  width: 24,
                                  height: 24,
                                ),
                                title: Text(
                                    "student_detail.label.completed_sessions"
                                        .tr),
                                trailing: Text(
                                  '${controller.student.value.completedSessions ?? 0}',
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
                            child: SizedBox(
                              height: 48,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );

                return CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      pinned: false,
                      stretch: false,
                      floating: false,
                      leading: CustomBackwardView(
                        color: Colors.white,
                        size: 24,
                      ),
                      expandedHeight:
                          230 - MediaQuery.of(context).padding.top + 32,
                      backgroundColor: Colors.red,
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          // 当前 SliverAppBar 的实际高度
                          final double currentHeight =
                              constraints.biggest.height;

                          // 折叠阈值：状态栏高度 + 工具栏高度
                          final double collapsedHeight =
                              MediaQuery.of(context).padding.top +
                                  kToolbarHeight;

                          // 只有当已折叠（或几乎折叠）时才显示标题
                          final bool showTitle =
                              currentHeight <= collapsedHeight + 1;

                          return FlexibleSpaceBar(
                            // ↓ 折叠后才给 title
                            title: showTitle
                                ? Text(
                                    'profile.setting.personal.center'.tr,
                                    style: Get.theme.textTheme.titleLarge
                                        ?.copyWith(
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                            centerTitle: false,
                            titlePadding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 48,
                            ),
                            stretchModes: const [
                              StretchMode.zoomBackground,
                              StretchMode.fadeTitle,
                            ],
                            background: Stack(
                              children: [
                                Obx(
                                  () =>
                                      controller.student.value.avatar != null &&
                                              controller.student.value.avatar!
                                                  .isNotEmpty
                                          ? Container(
                                              width: Get.width,
                                              height: 230,
                                              padding: EdgeInsets.zero,
                                              alignment: Alignment.center,
                                              child: CachedNetworkImage(
                                                imageUrl: controller
                                                    .student.value.avatar!,
                                                width: Get.width,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.only(
                                                top: kToolbarHeight + 24,
                                                bottom: 16,
                                              ),
                                              alignment: Alignment.topCenter,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/profile_bg.jpeg',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: Get.width,
                                    height: 300,
                                    color: Colors.transparent,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 8, sigmaY: 8), // 设置模糊程度
                                        child: Container(
                                          color:
                                              Colors.white.withAlpha(0), // 透明背景
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 24,
                                  top: 200,
                                  child: Container(
                                    width: 64,
                                    height: 64,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (c, i) => ListTile(title: Text("Item $i")),
                        childCount: 20,
                      ),
                    )
                  ],
                );
                return CustomScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      pinned: false,
                      snap: false,
                      expandedHeight: 230 - MediaQuery.of(context).padding.top,
                      backgroundColor: Get.theme.primaryColor,
                      leading: CustomBackwardView(
                        color: Colors.white,
                        size: 24,
                      ),
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          // 当前 SliverAppBar 的实际高度
                          final double currentHeight =
                              constraints.biggest.height;

                          // 折叠阈值：状态栏高度 + 工具栏高度
                          final double collapsedHeight =
                              MediaQuery.of(context).padding.top +
                                  kToolbarHeight;

                          // 只有当已折叠（或几乎折叠）时才显示标题
                          final bool showTitle =
                              currentHeight <= collapsedHeight + 1;

                          return FlexibleSpaceBar(
                            // ↓ 折叠后才给 title
                            title: showTitle
                                ? Text(
                                    'profile.setting.personal.center'.tr,
                                    style: Get.theme.textTheme.titleLarge
                                        ?.copyWith(
                                      color: Colors.white,
                                    ),
                                  )
                                : null,
                            centerTitle: false,
                            titlePadding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 48,
                            ),
                            stretchModes: const [
                              StretchMode.zoomBackground,
                              StretchMode.fadeTitle,
                            ],
                            background: Stack(
                              children: [
                                Obx(
                                  () =>
                                      controller.student.value.avatar != null &&
                                              controller.student.value.avatar!
                                                  .isNotEmpty
                                          ? Container(
                                              width: Get.width,
                                              height: 230,
                                              padding: EdgeInsets.zero,
                                              alignment: Alignment.center,
                                              child: CachedNetworkImage(
                                                imageUrl: controller
                                                    .student.value.avatar!,
                                                width: Get.width,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Container(
                                              padding: EdgeInsets.only(
                                                top: kToolbarHeight + 24,
                                                bottom: 16,
                                              ),
                                              alignment: Alignment.topCenter,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/images/profile_bg.jpeg',
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  child: Container(
                                    width: Get.width,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (c, i) => ListTile(title: Text("Item $i")),
                        childCount: 20,
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

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  const MyCustomAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return child;
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20.0);
}
