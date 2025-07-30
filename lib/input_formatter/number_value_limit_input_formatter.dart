import 'package:flutter/services.dart';

class NumberValueLimitInputFormatter extends TextInputFormatter {
  int? max;
  int? min;
  NumberValueLimitInputFormatter({
    this.max,
    this.min,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
      // return TextEditingValue(text: '${min ?? 0}');
    }

    if (newValue.composing.end != newValue.composing.start) {
      return oldValue;
    }
    if (int.parse(newValue.text) > (max ?? 100)) {
      return TextEditingValue(text: '${max ?? 100}');
    }
    if (int.parse(newValue.text) < (min ?? 0)) {
      return TextEditingValue(text: '${min ?? 0}');
    }
    return newValue;
  }
}
