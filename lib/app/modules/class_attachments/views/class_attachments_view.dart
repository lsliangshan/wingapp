import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/components/custom_indicator_builder/custom_indicator_builder.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';
import 'package:wingapp/components/empty_result/empty_result.dart';

import '../controllers/class_attachments_controller.dart';

class ClassAttachmentsView extends GetView<ClassAttachmentsController> {
  final String classId;
  const ClassAttachmentsView({
    super.key,
    required this.classId,
  });

  Widget _buildItem(BuildContext context, int index) {
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
          controller.gotoFilePreviewer(
            attachmentId: controller.attachments[index].id,
            fileUrl: controller.attachments[index].url,
            fileName: controller.attachments[index].filename,
          );
        },
        leading: SvgPicture.asset(
          'assets/svgs/icon_document.svg',
          width: 28,
          height: 28,
        ),
        tileColor: Get.theme.colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        title: Text(controller.attachments[index].filename),
        subtitle: Text(
          controller.attachments[index].updateAt ?? '',
          style: Get.theme.textTheme.bodySmall?.copyWith(
            color: Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
        ),
        contentPadding: EdgeInsets.only(left: 16, right: 0),
        trailing: Container(
          height: 48,
          width: 48,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  print('>>>>>>>>>> delete');
                },
                child: SvgPicture.asset(
                  'assets/svgs/icon_close.svg',
                  width: 20,
                  height: 20,
                ),
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
      appBar: AppBar(
        title: Obx(() => Text(
              'class_attachments.title'.tr.replaceAll(
                  '{class_name}', controller.classDetail.value.name ?? ''),
              style: Get.theme.textTheme.titleMedium,
            )),
        centerTitle: true,
        leading: const CustomBackwardView(),
        actions: [
          IconButton(
            onPressed: () {
              controller.gotoCreateAttachment();
            },
            icon: SvgPicture.asset(
              'assets/svgs/icon_plus.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(
                Get.theme.colorScheme.onSurface.withValues(alpha: 0.5),
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: CustomMaterialIndicator(
        onRefresh: controller.onRefresh,
        backgroundColor: Colors.white,
        indicatorBuilder: customIndicatorBuilder,
        child: GetBuilder(
          init: controller,
          id: 'update-class-attachments',
          builder: (_) {
            return FutureBuilder(
              future: controller.initClassAttachmentsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(
                    child: CustomLoader(),
                  );
                }
                if (controller.attachments.isEmpty) {
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
                                  controller.gotoCreateAttachment();
                                },
                                child: Text('class_attachments.btn.add'.tr),
                              ),
                              showSecondaryButton: true,
                              secondaryButton: FilledButton(
                                onPressed: () {
                                  controller.onRefresh();
                                },
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.black45,
                                ),
                                child: Text('class_attachments.btn.reload'.tr),
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
                      itemCount: controller.attachments.length,
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
