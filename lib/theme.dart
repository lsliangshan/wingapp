import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.system;
  ThemeMode get mode => _mode;
  set mode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }
}

Color primaryColor = const Color(0xFFFF7F50);
ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.light, // 黑暗模式
    primaryColor: primaryColor, // const Color.fromRGBO(155, 89, 182, 1), // 主颜色
    colorScheme: ColorScheme.light(
      primary: primaryColor, // 主颜色
      secondary: const Color.fromRGBO(255, 176, 61, 1), // 强调色
      error: const Color(0xFFFF3333),
      onPrimary: Colors.white,
    ),
    scaffoldBackgroundColor: const Color(0xFFF0F0F0),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    useMaterial3: true,
  );
}
