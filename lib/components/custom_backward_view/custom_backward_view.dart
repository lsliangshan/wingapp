import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

class CustomBackwardView extends GetView {
  final Color? color;
  final double? size;
  const CustomBackwardView({super.key, this.color, this.size});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        'assets/svgs/icon_arrow_left.svg',
        width: size ?? 20,
        height: size ?? 20,
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
