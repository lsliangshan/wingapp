import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  final Color? color;
  final double? size;
  const CustomLoader({super.key, this.color, this.size});

  @override
  Widget build(BuildContext context) {
    return CupertinoActivityIndicator(
      color: color ?? Get.theme.hintColor,
      radius: size ?? 14,
    );
  }
}
