import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFaFaFa),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            stretch: true,
            expandedHeight: 220,
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

                return FlexibleSpaceBar(
                  // ↓ 折叠后才给 title
                  title: showTitle ? const Text('个人中心') : null,
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
                        Image.asset(
                          'assets/images/default_avatar.png',
                          width: 80,
                          height: 80,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          '张老师',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '138-0013-8000',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  width: Get.width,
                  height: 120,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 16,
                    children: [
                      Card(
                        elevation: 1,
                        shadowColor: Color(0xFFfefefe),
                        child: Container(
                          width: 150,
                          height: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 16,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/tab_class_unselected.svg',
                                width: 32,
                                height: 32,
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
                                      '10',
                                      style: Get.theme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: Get.theme.primaryColor,
                                        fontSize: 26,
                                      ),
                                    ),
                                    Text(
                                      '班级总数',
                                      style: Get.theme.textTheme.bodyMedium
                                          ?.copyWith(
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
                      Card(
                        elevation: 1,
                        shadowColor: Color(0xFFfefefe),
                        child: Container(
                          width: 150,
                          height: 80,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            spacing: 16,
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/tab_student_unselected.svg',
                                width: 32,
                                height: 32,
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
                                      '37',
                                      style: Get.theme.textTheme.titleMedium
                                          ?.copyWith(
                                        color: Get.theme.primaryColor,
                                        fontSize: 26,
                                      ),
                                    ),
                                    Text(
                                      '学生总数',
                                      style: Get.theme.textTheme.bodyMedium
                                          ?.copyWith(
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
                    ],
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 0,
                  ),
                  title: Text(
                    '通用功能',
                    style: Get.theme.textTheme.titleMedium?.copyWith(
                      fontSize: 14,
                      color: Get.theme.disabledColor,
                    ),
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/svgs/icon_swap.svg',
                      width: 20,
                      height: 20,
                    ),
                    horizontalTitleGap: 6,
                    title: const Text('身份切换'),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    trailing: SvgPicture.asset(
                      'assets/svgs/icon_arrow_right.svg',
                      width: 20,
                      height: 20,
                    ),
                    onTap: () {
                      // TODO: 跳转老师管理页
                    },
                  ),
                ),
                Card(
                  elevation: 0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: ListTile(
                    leading: SvgPicture.asset(
                      'assets/svgs/tab_schedule_selected.svg',
                      width: 20,
                      height: 20,
                    ),
                    horizontalTitleGap: 6,
                    title: const Text('课表管理'),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    trailing: SvgPicture.asset(
                      'assets/svgs/icon_arrow_right.svg',
                      width: 20,
                      height: 20,
                    ),
                    onTap: () {
                      // TODO: 跳转老师管理页
                    },
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: Get.width,
              height: 2000,
            ),
          ),
        ],
      ),
    );
  }
}
