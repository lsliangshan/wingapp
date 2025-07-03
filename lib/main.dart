import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/locale/locale.dart';
import 'package:wingapp/services/localstorage.dart';
import 'package:wingapp/theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalstorageService localstorageService = LocalstorageService();
  String? localLanguage = await localstorageService.getString(LocalLanguageKey);
  if (localLanguage == null || localLanguage.isEmpty) {
    localLanguage = PlatformDispatcher.instance.locale.languageCode == 'zh'
        ? 'zh_CN'
        : 'en_US';

    await localstorageService.setString(LocalLanguageKey, localLanguage);
  }
  Locale locale =
      Locale(localLanguage.split('_')[0], localLanguage.split('_')[1]);

  initializeDateFormatting().then((_) => runApp(
        GetMaterialApp(
          title: "wingapp",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          debugShowCheckedModeBanner: false,
          translations: Messages(),
          locale: locale,
          fallbackLocale: const Locale('en', 'US'),
          theme: darkTheme(),
          themeMode: ThemeMode.light,
          defaultTransition: Transition.rightToLeft,
        ),
      ));
}
