import 'dart:ui';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:wingapp/app/data/app.config.dart';
import 'package:wingapp/database/daos/teacher.dao.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/locale/locale.dart';
import 'package:wingapp/services/dingtalk.dart';
import 'package:wingapp/services/localstorage.dart';
import 'package:wingapp/services/teacher.dart';
import 'package:wingapp/services/toast.dart';
import 'package:wingapp/theme.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();

  LocalstorageService localstorageService = LocalstorageService();
  String? localLanguage = await localstorageService.getString(LocalLanguageKey);
  if (localLanguage == null || localLanguage.isEmpty) {
    localLanguage = PlatformDispatcher.instance.locale.languageCode == 'zh'
        ? 'zh_CN'
        : 'en_US';

    await localstorageService.setString(LocalLanguageKey, localLanguage);
  }

  String? localRole = await localstorageService.getString(LocalRoleKey);
  if (localRole == null || localRole.isEmpty) {
    localRole = 'teacher';

    await localstorageService.setString(LocalRoleKey, localRole);
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
          locale: Locale('en', 'US'), // locale,
          fallbackLocale: const Locale('en', 'US'),
          theme: darkTheme(),
          themeMode: ThemeMode.light,
          defaultTransition: Transition.rightToLeft,
        ),
      ));
}

Future<void> initServices() async {
  LocalstorageService localstorageService = LocalstorageService();
  Get.lazyPut(() => localstorageService);

  ToastService toastService = ToastService();
  Get.lazyPut(() => toastService);

  EventBus eventBus = EventBus();
  Get.put<EventBus>(eventBus);

  AppDatabase db = AppDatabase();
  TeacherDao teacherDao = TeacherDao(db);
  Get.put<TeacherDao>(teacherDao);

  TeacherService teacherService = TeacherService();
  Get.put<TeacherService>(teacherService);

  DingtalkService dingtalkService = DingtalkService();
  Get.put<DingtalkService>(dingtalkService);
}
