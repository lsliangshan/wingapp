import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          // 页面
          'page.title.home': '首页',
          'page.title.class': '班级',
          'page.title.student': '学生',
          'page.title.schedule': '课表',
          'page.title.profile': '我的',
        },
        'en_US': {
          // 页面
          'page.title.home': 'Home',
          'page.title.class': 'Class',
          'page.title.student': 'Student',
          'page.title.schedule': 'Schedule',
          'page.title.profile': 'Profile',
        }
      };
}
