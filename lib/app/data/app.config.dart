// ignore_for_file: non_constant_identifier_names

import 'package:get/get_utils/get_utils.dart';
import 'package:wingapp/types/types.dart';

// List tabs = [
//   {
//     "icon": "assets/svgs/tab_gift.svg",
//     "label": 'page.title.gift'.tr,
//     "name": TabName.gift,
//     "page": const GiftView(),
//   },
//   {
//     "icon": "assets/svgs/tab_events.svg",
//     "label": 'page.title.events'.tr,
//     "name": TabName.events,
//     "page": const EventsView(),
//   },
//   {
//     "icon": "assets/svgs/tab_contact.svg",
//     "label": 'page.title.contact'.tr,
//     "name": TabName.contact,
//     "page": const ContactView(),
//   },
//   {
//     "icon": "assets/svgs/tab_profile.svg",
//     "label": 'page.title.profile'.tr,
//     "name": TabName.profile,
//     "page": const ProfileView(),
//   },
// ];

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
