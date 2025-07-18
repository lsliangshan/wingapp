import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wingapp/components/custom_loader/custom_loader.dart';

class ToastService extends GetxService {
  void showError({
    required String message,
    Duration? duration = const Duration(milliseconds: 5000),
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showSuccess({
    required String message,
    Duration? duration = const Duration(milliseconds: 5000),
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showMessage({
    required String message,
    Duration? duration = const Duration(milliseconds: 5000),
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  void showLoading<T>({
    required Future<T> Function() asyncFunction,
    String? message,
  }) {
    Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: Center(
        child: LoaderOverlay(
          overlayColor: Colors.transparent,
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 4.5,
                      sigmaY: 4.5,
                    ),
                    child: Center(
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomLoader(
                              color: Get.theme.colorScheme.surface,
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            Text(
                              message ?? 'toast.uploading'.tr,
                              textAlign: TextAlign.center,
                              style: Get.theme.textTheme.bodyMedium?.copyWith(
                                color: Get.theme.colorScheme.surface,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
