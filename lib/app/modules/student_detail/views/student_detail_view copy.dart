import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';

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

  // 头部
  Widget _buildHeader(BuildContext context, bool innerBoxIsScrolled) {
    return // SliverOverlapAbsorber 的作用是处理重叠滚动效果，
        // 防止 CustomScrollView 中的滚动视图与其他视图重叠。
        SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver:
          // SliverAppBar 的作用是创建可折叠的顶部应用程序栏，
          // 它可以随着滚动而滑动或固定在屏幕顶部，并且可以与其他 Sliver 小部件一起使用。
          SliverAppBar(
        title: const Text('滚动一致性'),
        pinned: true,
        elevation: 6, //影深
        expandedHeight: 300.0,
        forceElevated: innerBoxIsScrolled, //为true时展开有阴影
        flexibleSpace: FlexibleSpaceBar(
          background: Image.asset(
            "assets/images/profile_bg.jpeg",
            fit: BoxFit.cover,
          ),
        ),

        // 底部固定栏
        bottom: MyCustomAppBar(
          child: Column(
            children: [
              Container(
                width: Get.width,
                height: 100,
                color: Colors.greenAccent.withValues(alpha: 0.5),
                child: const Center(child: Text('固定高度内容')),
              ),
            ],
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
                      height: 300,
                      child: Obx(
                        () => controller.student.value.avatar != null &&
                                controller.student.value.avatar!.isNotEmpty
                            ? Container(
                                width: Get.width,
                                height: 230,
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                child: CachedNetworkImage(
                                  imageUrl: controller.student.value.avatar!,
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
                    ),
                    Positioned(
                      child: CustomScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                            pinned: false,
                            stretch: true,
                            floating: true,
                            expandedHeight:
                                230 - MediaQuery.of(context).padding.top,
                            backgroundColor: Colors.transparent,
                            leading: CustomBackwardView(
                              color: Colors.black,
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
                                          style: Get.theme.textTheme.titleMedium
                                              ?.copyWith(
                                            color: Colors.black,
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
                                  background: Container(
                                    width: Get.width,
                                    height: 230,
                                    color: Colors.transparent,
                                  ),
                                );
                              },
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Container(
                              width: Get.width,
                              // height: 100,
                              child: Stack(
                                children: [
                                  Container(
                                    width: Get.width,
                                    height: Get.width * 440 / 1080,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'assets/images/profile_mask.png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          bottom: 0,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: Get.width / 2,
                                                height: 32,
                                                // color: Colors.green,
                                              ),
                                              Container(
                                                width: Get.width / 2,
                                                height: 64,
                                                alignment: Alignment.centerLeft,
                                                child: ListTile(
                                                  title: Text(
                                                    controller
                                                        .student.value.name!,
                                                    style: Get.theme.textTheme
                                                        .titleLarge
                                                        ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  subtitle: Text(
                                                    controller.student.value
                                                                .gender ==
                                                            'male'
                                                        ? 'gender.male'.tr
                                                        : 'gender.female'.tr,
                                                    style: Get.theme.textTheme
                                                        .titleSmall
                                                        ?.copyWith(
                                                      color: Colors.black
                                                          .withValues(
                                                              alpha: 0.5),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: Get.width / 2,
                                                height: 32,
                                                // color: Colors.green,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: Get.width,
                                    height: 2000,
                                    margin: EdgeInsets.only(
                                      top: Get.width * 440 / 1080,
                                    ),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );

                // return CustomScrollView(
                //   physics: AlwaysScrollableScrollPhysics(),
                //   slivers: [
                //     SliverAppBar(
                //       floating: true,
                //       pinned: false,
                //       snap: false,
                //       expandedHeight: 230 - MediaQuery.of(context).padding.top,
                //       backgroundColor: Get.theme.primaryColor,
                //       leading: CustomBackwardView(
                //         color: Colors.white,
                //         size: 24,
                //       ),
                //       flexibleSpace: LayoutBuilder(
                //         builder: (context, constraints) {
                //           // 当前 SliverAppBar 的实际高度
                //           final double currentHeight =
                //               constraints.biggest.height;

                //           // 折叠阈值：状态栏高度 + 工具栏高度
                //           final double collapsedHeight =
                //               MediaQuery.of(context).padding.top +
                //                   kToolbarHeight;

                //           // 只有当已折叠（或几乎折叠）时才显示标题
                //           final bool showTitle =
                //               currentHeight <= collapsedHeight + 1;

                //           return FlexibleSpaceBar(
                //             // ↓ 折叠后才给 title
                //             title: showTitle
                //                 ? Text(
                //                     'profile.setting.personal.center'.tr,
                //                     style: Get.theme.textTheme.titleLarge
                //                         ?.copyWith(
                //                       color: Colors.white,
                //                     ),
                //                   )
                //                 : null,
                //             centerTitle: false,
                //             titlePadding: EdgeInsets.symmetric(
                //               vertical: 16,
                //               horizontal: 48,
                //             ),
                //             stretchModes: const [
                //               StretchMode.zoomBackground,
                //               StretchMode.fadeTitle,
                //             ],
                //             background: Stack(
                //               children: [
                //                 Obx(
                //                   () =>
                //                       controller.student.value.avatar != null &&
                //                               controller.student.value.avatar!
                //                                   .isNotEmpty
                //                           ? Container(
                //                               width: Get.width,
                //                               height: 230,
                //                               padding: EdgeInsets.zero,
                //                               alignment: Alignment.center,
                //                               child: CachedNetworkImage(
                //                                 imageUrl: controller
                //                                     .student.value.avatar!,
                //                                 width: Get.width,
                //                                 fit: BoxFit.cover,
                //                               ),
                //                             )
                //                           : Container(
                //                               padding: EdgeInsets.only(
                //                                 top: kToolbarHeight + 24,
                //                                 bottom: 16,
                //                               ),
                //                               alignment: Alignment.topCenter,
                //                               decoration: BoxDecoration(
                //                                 image: DecorationImage(
                //                                   image: AssetImage(
                //                                     'assets/images/profile_bg.jpeg',
                //                                   ),
                //                                   fit: BoxFit.cover,
                //                                 ),
                //                               ),
                //                             ),
                //                 ),
                //                 Positioned(
                //                   bottom: 0,
                //                   child: Container(
                //                     width: Get.width,
                //                     height: 100,
                //                     decoration: BoxDecoration(
                //                       color: Colors.red,
                //                       borderRadius: BorderRadius.circular(100),
                //                     ),
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           );
                //         },
                //       ),
                //     ),
                //     SliverList(
                //       delegate: SliverChildBuilderDelegate(
                //         (c, i) => ListTile(title: Text("Item $i")),
                //         childCount: 20,
                //       ),
                //     ),
                //   ],
                // );
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
