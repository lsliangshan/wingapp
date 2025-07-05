import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wingapp/app/routes/app_pages.dart';

// https://www.figma.com/design/80lkFHWAzQW1iXR1PduJBn/Empty-State-Illustrations--Community-?node-id=1-1460&t=BAqhxeFg9l3AwayU-0

class EmptyResult extends StatelessWidget {
  const EmptyResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            'assets/svgs/empty_result.svg',
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 16),
          Text(
            'teacher.tip.empty'.tr,
            style: Get.theme.textTheme.titleMedium?.copyWith(
              color: Color(0xFFC8C8C8),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: () {
              Get.toNamed(Routes.ADD_TEACHER);
            },
            child: Text('teacher.btn.add'.tr),
          ),
        ],
      ),
    );
  }
}
