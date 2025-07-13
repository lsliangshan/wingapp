import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:wingapp/app/modules/choose_at_users/controllers/choose_at_users_controller.dart';
import 'package:wingapp/components/custom_backward_view/custom_backward_view.dart';
import 'package:wingapp/models/login_info.model.dart';

class ChooseAtUsersView extends GetView<ChooseAtUsersController> {
  const ChooseAtUsersView({super.key});

  Widget _buildUserItem(LoginInfo user, int index) {
    return GetBuilder(
        id: 'update-keyword',
        init: controller,
        builder: (_) {
          String keyword = controller.keywordController.text.toLowerCase();

          bool matchInName = keyword.isNotEmpty &&
              user.name != null &&
              user.name!.toLowerCase().contains(keyword);
          bool matchInEnName = keyword.isNotEmpty &&
              user.enName != null &&
              user.enName!.toLowerCase().contains(keyword);

          if (!matchInName && !matchInEnName && keyword.isNotEmpty) {
            return const SizedBox();
          }

          Widget nameWidget = RichText(
            text: TextSpan(
              text: user.name ?? '',
              style: Get.theme.textTheme.titleMedium,
            ),
          );
          Widget enNameWidget = RichText(
            text: TextSpan(
              text: user.enName ?? '',
              style: Get.theme.textTheme.labelMedium?.copyWith(
                color: Get.theme.hintColor.withValues(alpha: 0.5),
              ),
            ),
          );

          if (matchInName) {
            int nameIndex = user.name!.toLowerCase().indexOf(keyword);
            nameWidget = RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: user.name!.substring(0, nameIndex),
                    style: Get.theme.textTheme.titleMedium,
                  ),
                  TextSpan(
                    text: user.name!
                        .substring(nameIndex, nameIndex + keyword.length),
                    style: Get.theme.textTheme.titleMedium?.copyWith(
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: user.name!.substring(nameIndex + keyword.length),
                    style: Get.theme.textTheme.titleMedium,
                  ),
                ],
              ),
            );
          }

          if (matchInEnName) {
            int nameIndex = user.enName!.toLowerCase().indexOf(keyword);
            enNameWidget = RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: user.enName!.substring(0, nameIndex),
                    style: Get.theme.textTheme.labelMedium?.copyWith(
                      color: Get.theme.hintColor.withValues(alpha: 0.5),
                    ),
                  ),
                  TextSpan(
                    text: user.enName!
                        .substring(nameIndex, nameIndex + keyword.length),
                    style: Get.theme.textTheme.labelMedium?.copyWith(
                      color: Get.theme.primaryColor,
                    ),
                  ),
                  TextSpan(
                    text: user.enName!.substring(nameIndex + keyword.length),
                    style: Get.theme.textTheme.labelMedium?.copyWith(
                      color: Get.theme.hintColor.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            );
          }

          if (controller.multiAt.isTrue) {
            return Card(
              margin: EdgeInsets.only(
                left: 12,
                right: 12,
                top: 4,
                bottom: 4,
              ),
              elevation: 0,
              clipBehavior: Clip.hardEdge,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CheckboxListTile(
                value: controller.selectedUsers.contains(user),
                onChanged: (value) {
                  controller.toggleAtUser(user: user, isAdd: value ?? false);
                },
                checkboxShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                contentPadding: EdgeInsets.only(
                  left: 16,
                  right: 8,
                ),
                title: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.only(right: 16),
                      child: user.avatar != null && user.avatar!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: user.avatar!,
                              imageBuilder: (context, imageProvider) =>
                                  CircleAvatar(
                                backgroundImage: imageProvider,
                                radius: 15,
                              ),
                              placeholder: (context, url) =>
                                  const Icon(Icons.person),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.person),
                            )
                          : const Icon(Icons.person),
                    ),
                    Column(
                      children: [
                        if (user.enName != null && user.enName!.isNotEmpty)
                          SizedBox(
                            height: 6,
                          ),
                        nameWidget,
                        if (user.enName != null && user.enName!.isNotEmpty)
                          SizedBox(
                            height: 2,
                          ),
                        if (user.enName != null && user.enName!.isNotEmpty)
                          enNameWidget,
                        if (user.enName != null && user.enName!.isNotEmpty)
                          SizedBox(
                            height: 8,
                          ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
          return Card(
            margin: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 4,
              bottom: 4,
            ),
            elevation: 0,
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: SizedBox(
                width: 30,
                height: 30,
                child: user.avatar != null && user.avatar!.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: user.avatar!,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundImage: imageProvider,
                          radius: 15,
                        ),
                        placeholder: (context, url) => const Icon(Icons.person),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.person),
                      )
                    : const Icon(Icons.person),
              ),
              contentPadding: EdgeInsets.only(
                left: 16,
                right: 8,
              ),
              title: nameWidget,
              subtitle: user.enName != null && user.enName!.isNotEmpty
                  ? enNameWidget
                  : null,
              onTap: () {
                controller.chooseAtUser(user: user);
              },
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'choose_at_users.title'.tr,
          style: Get.theme.textTheme.titleMedium,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leadingWidth: 64,
        leading: Obx(() => controller.multiAt.isTrue
            ? TextButton(
                onPressed: () {
                  controller.setMultiAt(false);
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.pink,
                ),
                child: Text('choose_at_users.multi_select.off'.tr),
              )
            : const CustomBackwardView()),
        actions: [
          GetBuilder(
            id: 'update-selected-users',
            init: controller,
            builder: (_) {
              if (controller.multiAt.isTrue) {
                return Container(
                  height: 26,
                  margin: const EdgeInsets.only(right: 12),
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                    ),
                    onPressed: controller.selectedUsers.isEmpty
                        ? null
                        : () {
                            controller.chooseAtUsers();
                          },
                    child: Text(
                      "${'choose_at_users.confirm'.tr} ${controller.selectedUsers.isNotEmpty ? '(${controller.selectedUsers.length})' : ''}",
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                );
              } else {
                return TextButton(
                  onPressed: () {
                    controller.setMultiAt(true);
                  },
                  child: Text('choose_at_users.multi_select'.tr),
                );
              }
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            height: 56,
            child: TextField(
              controller: controller.keywordController,
              focusNode: controller.keywordFocusNode,
              onTapOutside: (event) {
                controller.keywordFocusNode.unfocus();
              },
              decoration: InputDecoration(
                hintText: 'choose_at_users.search'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Get.theme.hintColor.withValues(alpha: 0.05),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: Get.theme.hintColor.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ),
      ),
      body: GetBuilder(
        init: controller,
        id: 'update-selected-users',
        builder: (_) {
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 4,
                ),
              ),
              SliverList.builder(
                itemCount: controller.users.length,
                itemBuilder: (context, index) {
                  return _buildUserItem(controller.users[index], index);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
