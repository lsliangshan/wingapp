import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

// https://www.figma.com/design/80lkFHWAzQW1iXR1PduJBn/Empty-State-Illustrations--Community-?node-id=1-1460&t=BAqhxeFg9l3AwayU-0

class EmptyResult extends StatelessWidget {
  final Function()? onPressed;
  final Widget? mainButton;
  final bool showMainButton;
  final bool showSecondaryButton;
  final Widget? secondaryButton;
  const EmptyResult({
    super.key,
    this.onPressed,
    this.mainButton,
    this.showMainButton = true,
    this.showSecondaryButton = false,
    this.secondaryButton,
  });

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
          if (showMainButton)
            mainButton ??
                FilledButton(
                  onPressed: () {
                    onPressed?.call();
                  },
                  child: Text('teacher.btn.add'.tr),
                ),
          if (showMainButton && showSecondaryButton) const SizedBox(height: 16),
          if (showSecondaryButton)
            secondaryButton ??
                TextButton(
                  onPressed: () {},
                  child: Text('teacher.btn.add'.tr),
                ),
        ],
      ),
    );
  }
}
