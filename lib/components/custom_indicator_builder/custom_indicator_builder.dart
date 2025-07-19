import 'dart:math';
import 'dart:ui';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customIndicatorBuilder(
    BuildContext context, IndicatorController controller) {
  return Stack(
    children: [
      Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(40),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // 设置模糊程度
              child: Container(
                color: Colors.white.withAlpha(0), // 透明背景
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(6.0),
        child: CircularProgressIndicator(
          color: Get.theme.primaryColor,
          strokeWidth: 2,
          value: controller.state.isLoading ? null : min(controller.value, 1.0),
        ),
      )
    ],
  );
}
