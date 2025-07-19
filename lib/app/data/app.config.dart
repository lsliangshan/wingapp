// ignore_for_file: non_constant_identifier_names

import 'package:get/get_utils/get_utils.dart';
import 'package:wingapp/app/modules/class/views/class_view.dart';
import 'package:wingapp/app/modules/discovery/views/discovery_view.dart';
import 'package:wingapp/app/modules/profile/views/profile_view.dart';
import 'package:wingapp/app/modules/schedule/views/schedule_view.dart';
import 'package:wingapp/app/modules/student/views/student_view.dart';
import 'package:wingapp/types/types.dart';

List tabs = [
  {
    "icon": "assets/svgs/tab_home_unselected.svg",
    "icon_selected": "assets/svgs/tab_home_selected.svg",
    "label": 'tab.home'.tr,
    "name": TabName.home,
    "page": const DiscoveryView(),
  },
  {
    "icon": "assets/svgs/tab_class_unselected.svg",
    "icon_selected": "assets/svgs/tab_class_selected.svg",
    "label": 'tab.class'.tr,
    "name": TabName.tclass,
    "page": const ClassView(),
  },
  {
    "icon": "assets/svgs/tab_student_unselected.svg",
    "icon_selected": "assets/svgs/tab_student_selected.svg",
    "label": 'tab.student'.tr,
    "name": TabName.student,
    "page": StudentView(),
  },
  {
    "icon": "assets/svgs/tab_schedule_unselected.svg",
    "icon_selected": "assets/svgs/tab_schedule_selected.svg",
    "label": 'tab.schedule'.tr,
    "name": TabName.schedule,
    "page": const ScheduleView(),
  },
  {
    "icon": "assets/svgs/tab_profile_unselected.svg",
    "icon_selected": "assets/svgs/tab_profile_selected.svg",
    "label": 'tab.profile'.tr,
    "name": TabName.profile,
    "page": const ProfileView(),
  },
];

List<Map<String, String>> languages = [
  {
    "label": "简体中文",
    "name": "profile.language.zh_CN",
    "value": "zh_CN",
  },
  {
    "label": "English",
    "name": "profile.language.en_US",
    "value": "en_US",
  },
];

String LocalLanguageKey = 'current-language';

// 当前角色
// teacher
// student
String LocalRoleKey = 'current-role';

List<Map<String, String>> genders = [
  {
    "label": "gender.male".tr,
    "value": Gender.male,
  },
  {
    "label": "gender.female".tr,
    "value": Gender.female,
  },
];

List<Map<String, String>> teacherTypes = [
  {
    "label": "type.full_time".tr,
    "value": TeacherType.fullTime,
  },
  {
    "label": "type.part_time".tr,
    "value": TeacherType.partTime,
  },
];
