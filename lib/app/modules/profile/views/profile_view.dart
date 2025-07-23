import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_indicator_builder/custom_indicator_builder.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  Widget _buildSummaryCard({
    required String type,
    required String count,
    required bool isAdminTeacher,
  }) {
    String iconPath = '';
    String label = '';
    switch (type) {
      case 'class':
        iconPath = 'assets/svgs/tab_class_unselected.svg';
        label = isAdminTeacher
            ? 'profile.summary.class.short'.tr
            : 'profile.summary.class'.tr;
        break;
      case 'student':
        iconPath = 'assets/svgs/tab_student_unselected.svg';
        label = isAdminTeacher
            ? 'profile.summary.student.short'.tr
            : 'profile.summary.student'.tr;
        break;
      case 'teacher':
        iconPath = 'assets/svgs/tab_profile_unselected.svg';
        label = isAdminTeacher
            ? 'profile.summary.teacher.short'.tr
            : 'profile.summary.teacher'.tr;
        break;
      default:
        iconPath = 'assets/svgs/tab_class_unselected.svg';
        label = isAdminTeacher
            ? 'profile.summary.class.short'.tr
            : 'profile.summary.class'.tr;
        break;
    }

    return GestureDetector(
      onTap: () {
        controller.gotoDetail(type: type);
      },
      child: Card(
        elevation: 1,
        shadowColor: Color(0xFFfefefe),
        child: Container(
          // width: 150,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: isAdminTeacher ? 6 : 16,
            children: [
              SvgPicture.asset(
                iconPath,
                width: isAdminTeacher ? 24 : 32,
                height: isAdminTeacher ? 24 : 32,
                colorFilter: const ColorFilter.mode(
                  Color(0xFFB59F9D),
                  BlendMode.srcIn,
                ),
              ),
              VerticalDivider(
                color: const Color(0xFFB59F9D).withValues(
                  alpha: 0.4,
                ),
                thickness: 0.7,
                width: 1,
                indent: 28,
                endIndent: 28,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      count,
                      style: Get.theme.textTheme.titleMedium?.copyWith(
                        color: Get.theme.primaryColor,
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      label,
                      style: Get.theme.textTheme.bodyMedium?.copyWith(
                        color: const Color(0xFFB59F9D),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSettingItem({
    required String title,
    required String iconPath,
    required VoidCallback onTap,
    String? trailingText,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        leading: SvgPicture.asset(
          iconPath,
          width: 20,
          height: 20,
        ),
        horizontalTitleGap: 6,
        title: Text(title),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 4,
          children: [
            if (trailingText != null)
              Text(
                trailingText,
                style: Get.theme.textTheme.bodyMedium?.copyWith(
                  color: Get.theme.hintColor.withValues(alpha: 0.3),
                ),
              ),
            SvgPicture.asset(
              'assets/svgs/icon_arrow_right.svg',
              width: 20,
              height: 20,
              colorFilter: ColorFilter.mode(
                Get.theme.colorScheme.onSurface.withValues(alpha: 0.18),
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFaFaFa),
      body: CustomMaterialIndicator(
        onRefresh: controller.onRefresh,
        backgroundColor: Colors.white,
        indicatorBuilder: customIndicatorBuilder,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              stretch: true,
              expandedHeight: 230,
              backgroundColor: Get.theme.primaryColor,
              flexibleSpace: LayoutBuilder(
                builder: (context, constraints) {
                  // 当前 SliverAppBar 的实际高度
                  final double currentHeight = constraints.biggest.height;

                  // 折叠阈值：状态栏高度 + 工具栏高度
                  final double collapsedHeight =
                      MediaQuery.of(context).padding.top + kToolbarHeight;

                  // 只有当已折叠（或几乎折叠）时才显示标题
                  final bool showTitle = currentHeight <= collapsedHeight + 1;

                  return GetBuilder(
                    id: 'update-login-info',
                    init: controller,
                    builder: (_) {
                      return FlexibleSpaceBar(
                        // ↓ 折叠后才给 title
                        title: showTitle
                            ? Text(
                                controller.isLoggedIn.value
                                    ? '${controller.loginInfo.value?.enName ?? controller.loginInfo.value?.name}'
                                    : 'profile.setting.personal.center'.tr,
                                style: Get.theme.textTheme.titleLarge?.copyWith(
                                  color: Colors.white,
                                ),
                              )
                            : null,
                        centerTitle: false,
                        titlePadding: EdgeInsets.symmetric(
                          vertical: 16,
                          horizontal: 16,
                        ),
                        stretchModes: const [
                          StretchMode.zoomBackground,
                          StretchMode.fadeTitle,
                        ],
                        background: Container(
                          padding: EdgeInsets.only(
                            top: kToolbarHeight + 24,
                            bottom: 16,
                          ),
                          alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (controller.isLoggedIn.isTrue &&
                                  controller.loginInfo.value != null &&
                                  controller.loginInfo.value!.avatar != null &&
                                  controller
                                      .loginInfo.value!.avatar!.isNotEmpty)
                                Image.network(
                                  controller.loginInfo.value!.avatar!,
                                  width: 80,
                                  height: 80,
                                )
                              else
                                Image.asset(
                                  'assets/images/default_avatar.png',
                                  width: 80,
                                  height: 80,
                                ),
                              const SizedBox(height: 12),
                              Text(
                                controller.isLoggedIn.value
                                    ? '${controller.loginInfo.value?.enName ?? controller.loginInfo.value?.name}'
                                    : 'profile.setting.login.not.logged.in'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 4),
                              if (controller.isLoggedIn.value)
                                Text(
                                  controller.loginInfo.value?.mobile ?? '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.white70),
                                )
                              else
                                ElevatedButton(
                                  onPressed: controller.isDingTalkLogining.value
                                      ? null
                                      : () {
                                          controller.dingTalkLogin();
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    disabledBackgroundColor: Colors.green,
                                  ),
                                  child: controller.isDingTalkLogining.value
                                      ? CustomLoader(
                                          size: 8,
                                          color: Get.theme.disabledColor,
                                        )
                                      : Text(
                                          'profile.setting.login.with.dingtalk'
                                              .tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(color: Colors.black),
                                        ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  GetBuilder(
                    id: 'update-summary-counts',
                    init: controller,
                    builder: (_) {
                      return Container(
                        width: Get.width,
                        height: 120,
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(
                          horizontal: controller.isAdminTeacher.value ? 0 : 16,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: controller.isAdminTeacher.value ? 0 : 12,
                          children: [
                            Expanded(
                              child: _buildSummaryCard(
                                type: 'class',
                                count: controller
                                        .summaryCounts.value?['classCount']
                                        ?.toString() ??
                                    '0',
                                isAdminTeacher: controller.isAdminTeacher.value,
                              ),
                            ),
                            if (controller.isAdminTeacher.value)
                              Expanded(
                                child: _buildSummaryCard(
                                  type: 'teacher',
                                  count: controller
                                          .summaryCounts.value?['teacherCount']
                                          ?.toString() ??
                                      '0',
                                  isAdminTeacher:
                                      controller.isAdminTeacher.value,
                                ),
                              ),
                            Expanded(
                              child: _buildSummaryCard(
                                type: 'student',
                                count: controller
                                        .summaryCounts.value?['studentCount']
                                        ?.toString() ??
                                    '0',
                                isAdminTeacher: controller.isAdminTeacher.value,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    title: Text(
                      'profile.setting.business.function'.tr,
                      style: Get.theme.textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                        color: Get.theme.disabledColor,
                      ),
                    ),
                  ),
                  Obx(() => controller.isAdminTeacher.value
                      ? _buildSettingItem(
                          title: 'profile.setting.teacher.manage'.tr,
                          iconPath: 'assets/svgs/icon_teacher_manage.svg',
                          onTap: () {
                            controller.navigateToTeacherManage();
                          },
                        )
                      : const SizedBox.shrink()),
                  Obx(() => controller.isAdminTeacher.value
                      ? const Divider(
                          height: 1,
                          indent: 30,
                          endIndent: 30,
                          color: Color(0xFFF8F8F8),
                        )
                      : const SizedBox.shrink()),
                  _buildSettingItem(
                    title: 'profile.setting.class.manage'.tr,
                    iconPath: 'assets/svgs/tab_class_unselected.svg',
                    onTap: () {
                      controller.navigateToClassManage();
                    },
                  ),
                  const Divider(
                    height: 1,
                    indent: 30,
                    endIndent: 30,
                    color: Color(0xFFF8F8F8),
                  ),
                  _buildSettingItem(
                    title: 'profile.setting.schedule.manage'.tr,
                    iconPath: 'assets/svgs/tab_schedule_selected.svg',
                    onTap: () {
                      // TODO: 跳转老师管理页
                    },
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    title: Text(
                      'profile.setting.general.function'.tr,
                      style: Get.theme.textTheme.titleMedium?.copyWith(
                        fontSize: 14,
                        color: Get.theme.disabledColor,
                      ),
                    ),
                  ),
                  _buildSettingItem(
                    title: 'profile.setting.language.switch'.tr,
                    iconPath: 'assets/svgs/icon_swap.svg',
                    trailingText:
                        Get.locale?.languageCode == 'zh' ? '中文' : 'English',
                    onTap: () {
                      controller.switchLanguage();
                    },
                  ),
                  GetBuilder(
                    id: 'update-login-info',
                    init: controller,
                    builder: (_) {
                      if (controller.isLoggedIn.value) {
                        return GestureDetector(
                          onTap: () {
                            controller.logout();
                          },
                          child: Container(
                            width: Get.width,
                            height: 64,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'profile.setting.logout'.tr,
                                  style:
                                      Get.theme.textTheme.bodyMedium?.copyWith(
                                    color: Get.theme.colorScheme.error,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     width: Get.width,
            //     height: 2000,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
