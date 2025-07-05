import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          // 页面
          'tab.home': '首页',
          'tab.class': '班级',
          'tab.student': '学生',
          'tab.schedule': '课表',
          'tab.profile': '我的',

          // 老师管理页面
          'page.teacher.title': '老师管理',

          // 我的页面
          'profile.summary.class': '班级总数',
          'profile.summary.class.short': '班级',
          'profile.summary.student': '学生总数',
          'profile.summary.student.short': '学生',
          'profile.summary.teacher': '老师总数',
          'profile.summary.teacher.short': '老师',
          'profile.summary.general.function': '通用功能',
          'profile.setting.teacher.manage': '老师管理',
          'profile.setting.schedule.manage': '课表管理',
          'profile.setting.class.manage': '班级管理',
          'profile.setting.student.manage': '学生管理',
          'profile.setting.identity.switch': '身份切换',
          'profile.setting.logout': '退出登录',
          'profile.setting.login.with.dingtalk': '钉钉授权登录',
          'profile.setting.login.not.logged.in': '未登录',
          'profile.setting.personal.center': '个人中心',

          // Toast
          'toast.login.success': '登录成功',
          'toast.login.failed': '登录失败',
          'toast.logout.success': '退出成功',
          'toast.logout.failed': '退出失败',
        },
        'en_US': {
          // 页面
          'tab.home': 'Home',
          'tab.class': 'Class',
          'tab.student': 'Student',
          'tab.schedule': 'Schedule',
          'tab.profile': 'Profile',

          // 老师管理页面
          'page.teacher.title': 'Teacher Management',

          // 我的页面
          'profile.summary.class': 'Class Total',
          'profile.summary.class.short': 'Class',
          'profile.summary.student': 'Student Total',
          'profile.summary.student.short': 'Student',
          'profile.summary.teacher': 'Teacher Total',
          'profile.summary.teacher.short': 'Teacher',
          'profile.setting.general.function': 'General Settings',
          'profile.setting.teacher.manage': 'Teacher Management',
          'profile.setting.schedule.manage': 'Schedule Management',
          'profile.setting.class.manage': 'Class Management',
          'profile.setting.student.manage': 'Student Management',
          'profile.setting.identity.switch': 'Identity Switch',
          'profile.setting.logout': 'Logout',
          'profile.setting.login.with.dingtalk': 'Dingtalk Authorization Login',
          'profile.setting.login.not.logged.in': 'Not Logged In',
          'profile.setting.personal.center': 'Personal Center',

          // Toast
          'toast.login.success': 'Login Success',
          'toast.login.failed': 'Login Failed',
          'toast.logout.success': 'Logout Success',
          'toast.logout.failed': 'Logout Failed',
        }
      };
}
