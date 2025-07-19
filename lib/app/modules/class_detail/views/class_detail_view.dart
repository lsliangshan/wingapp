import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';

import '../controllers/class_detail_controller.dart';

class ClassDetailView extends GetView<ClassDetailController> {
  final String classId;
  const ClassDetailView({super.key, required this.classId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              '【${controller.classDetail.value.name}】${'class_detail.title'.tr}',
              style: Get.theme.textTheme.titleMedium,
            )),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        leading: const CustomBackwardView(),
      ),
      body: FutureBuilder(
        future: controller.initClassDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CustomLoader(),
            );
          }
          return GetBuilder(
            init: controller,
            tag: 'update-class-detail',
            builder: (_) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: const SizedBox(
                      height: 16,
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
                        tileColor: Get.theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: SvgPicture.asset(
                          'assets/svgs/tab_profile_unselected.svg',
                          width: 24,
                          height: 24,
                        ),
                        title: Text("teacher".tr),
                        trailing: Text(
                          "${controller.classDetail.value.teacherName ?? ''} (${controller.classDetail.value.teacherEnName ?? ''})",
                          style: Get.theme.textTheme.bodyMedium?.copyWith(
                            color: Get.theme.hintColor.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(
                      color: Get.theme.dividerColor.withValues(alpha: 0.02),
                      thickness: 1,
                      height: 1,
                      indent: 20,
                      endIndent: 20,
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
                        onTap: () {
                          controller.goToStudents();
                        },
                        tileColor: Get.theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: SvgPicture.asset(
                          'assets/svgs/tab_student_unselected.svg',
                          width: 24,
                          height: 24,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 16,
                          right: 12,
                        ),
                        title: Text("student".tr),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "${controller.studentsCount.value}",
                              style: Get.theme.textTheme.bodyMedium?.copyWith(
                                color:
                                    Get.theme.hintColor.withValues(alpha: 0.5),
                              ),
                            ),
                            const SizedBox(width: 4),
                            SvgPicture.asset(
                              'assets/svgs/icon_arrow_right.svg',
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(
                                Colors.grey,
                                BlendMode.srcIn,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(
                      color: Get.theme.dividerColor.withValues(alpha: 0.02),
                      thickness: 1,
                      height: 1,
                      indent: 20,
                      endIndent: 20,
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
                        tileColor: Get.theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: SvgPicture.asset(
                          'assets/svgs/tab_schedule_unselected.svg',
                          width: 24,
                          height: 24,
                        ),
                        title: Text("schedule".tr),
                        trailing: Text(
                          "${controller.classDetail.value.teacherName ?? ''} (${controller.classDetail.value.teacherEnName ?? ''})",
                          style: Get.theme.textTheme.bodyMedium?.copyWith(
                            color: Get.theme.hintColor.withValues(alpha: 0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(
                      color: Get.theme.dividerColor.withValues(alpha: 0.02),
                      thickness: 1,
                      height: 1,
                      indent: 20,
                      endIndent: 20,
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
                        onTap: () {
                          controller.goToSendRobotMessage();
                        },
                        tileColor: Get.theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: SvgPicture.asset(
                          'assets/svgs/icon_notification.svg',
                          width: 24,
                          height: 24,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 16,
                          right: 12,
                        ),
                        title: Text("notification".tr),
                        trailing: SvgPicture.asset(
                          'assets/svgs/icon_arrow_right.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Divider(
                      color: Get.theme.dividerColor.withValues(alpha: 0.02),
                      thickness: 1,
                      height: 1,
                      indent: 20,
                      endIndent: 20,
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
                        onTap: () {
                          controller.goToAttachments();
                        },
                        tileColor: Get.theme.colorScheme.surface,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        leading: SvgPicture.asset(
                          'assets/svgs/icon_attachments.svg',
                          width: 26,
                          height: 26,
                        ),
                        contentPadding: EdgeInsets.only(
                          left: 16,
                          right: 12,
                        ),
                        title: Text("attachments".tr),
                        trailing: SvgPicture.asset(
                          'assets/svgs/icon_arrow_right.svg',
                          width: 20,
                          height: 20,
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
