import 'package:flutter/services.dart';

class PureNumberInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^[0-9]+$');

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    if (newValue.composing.end != newValue.composing.start) {
      return oldValue;
    }
    if (_regExp.hasMatch(newValue.text)) {
      return newValue.copyWith(text: newValue.text); // 输入内容符合正则表达式
    }
    return oldValue; // 不符合时，保持旧值
  }
}
