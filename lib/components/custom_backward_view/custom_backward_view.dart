import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class CustomBackwardView extends GetView {
  final Color? color;
  const CustomBackwardView({super.key, this.color});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/svgs/icon_arrow_left.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(
          color ?? Color(0xFF000000),
          BlendMode.srcIn,
        ),
      ),
      onPressed: () {
        Get.back();
      },
    );
  }
}
