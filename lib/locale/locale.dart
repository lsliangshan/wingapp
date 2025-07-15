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

          // 我的页面
          'profile.summary.class': '班级总数',
          'profile.summary.class.short': '班级',
          'profile.summary.student': '学生总数',
          'profile.summary.student.short': '学生',
          'profile.summary.teacher': '老师总数',
          'profile.summary.teacher.short': '老师',
          'profile.setting.general.function': '通用功能',
          'profile.setting.teacher.manage': '老师管理',
          'profile.setting.schedule.manage': '课表管理',
          'profile.setting.class.manage': '班级管理',
          'profile.setting.student.manage': '学生管理',
          'profile.setting.identity.switch': '身份切换',
          'profile.setting.logout': '退出登录',
          'profile.setting.login.with.dingtalk': '钉钉授权登录',
          'profile.setting.login.not.logged.in': '未登录',
          'profile.setting.personal.center': '个人中心',

          // 老师管理页面
          'teacher.title': '老师管理',
          'teacher.btn.add': '添加老师',
          'teacher.tip.empty': '暂无数据',

          // 班级管理页面
          'class.title': '班级管理',
          'class.btn.add': '添加班级',
          'class.tip.empty': '暂无数据',
          'class.btn.reload': '刷新',

          // 添加老师页面
          'add_teacher.title': '添加老师',
          'add_teacher.form_data.name': '姓名',
          'add_teacher.form_data.name.hint': '请输入老师姓名',
          'add_teacher.form_data.en_name': '英文名',
          'add_teacher.form_data.en_name.hint': '请输入老师英文名',
          'add_teacher.form_data.gender': '性别',
          'add_teacher.form_data.gender.hint': '请选择老师性别',
          'add_teacher.form_data.type': '类型',
          'add_teacher.form_data.type.hint': '请选择老师类型',
          'add_teacher.form_data.dingtalk.login': '钉钉登录',
          'add_teacher.form_data.btn.save': '保存',
          'add_teacher.form_data.btn.saveAndBack': '保存并返回',

          // 添加班级页面
          'add_class.title': '添加班级',
          'add_class.form_data.name': '班级名称',
          'add_class.form_data.name.hint': '请输入班级名称',
          'add_class.form_data.teacher': '老师',
          'add_class.form_data.teacher.hint': '请选择老师',
          'add_class.form_data.icon': '班级图标',
          'add_class.form_data.icon.hint': '请选择班级图标',
          'add_class.form_data.btn.save': '保存',
          'add_class.form_data.btn.saveAndBack': '保存并返回',

          // 班级详情页面
          'class_detail.title': '班级详情',
          'class_detail.init.failed': '获取班级详情失败',

          // 选择老师页面
          'choose_teacher.title': '选择老师',

          // 选择@用户页面
          'choose_at_users.title': '选择提醒用户',
          'choose_at_users.search': '搜索',
          'choose_at_users.confirm': '确认',
          'choose_at_users.multi_select': '多选',
          'choose_at_users.multi_select.off': '取消',
          'choose_at_users.at_all': '所有人',

          // 发送机器人消息页面
          'send_robot_message.title': '发送机器人消息',
          'send_robot_message.hint_text': '请输入消息内容',
          'send_robot_message.load_more_message': '加载更多消息',
          'send_robot_message.no_more_message': '没有更多消息了',
          'send_robot_message.has_new_message': '新消息',

          // 未登录页面
          'need_login.tip': '需要登录',
          'need_login.btn.login': '钉钉授权登录',

          // Toast
          'toast.login.success': '登录成功',
          'toast.login.failed': '登录失败',
          'toast.logout.success': '退出成功',
          'toast.logout.failed': '退出失败',
          'toast.add_teacher.name_required': '老师姓名不能为空',
          'toast.add_teacher.en_name_required': '老师英文名不能为空',
          'toast.add_teacher.save.success': '保存成功',
          'toast.add_teacher.save.fail': '保存失败',
          'toast.refresh.success': '刷新成功',
          'toast.refresh.failed': '刷新失败',
          'toast.add_class.name_required': '班级名称不能为空',
          'toast.add_class.save.success': '保存成功',
          'toast.add_class.save.fail': '保存失败',

          // 加载更多
          'load_more.tips.no_more': '没有更多数据了',

          // 底部弹窗
          'bottom_sheet.choose_gender.title': '选择性别',
          'bottom_sheet.choose_type.title': '选择老师类型',
          'bottom_sheet.choose_teacher.title': '选择老师',

          // 性别
          'gender.male': '男',
          'gender.female': '女',

          // 类型
          'type.full_time': '全职老师',
          'type.part_time': '兼职老师',

          'teacher': '老师',
          'student': '学生',
          'schedule': '课表',
          'notification': '通知',
        },
        'en_US': {
          // 页面
          'tab.home': 'Home',
          'tab.class': 'Class',
          'tab.student': 'Student',
          'tab.schedule': 'Schedule',
          'tab.profile': 'Profile',

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

          // 老师管理页面
          'teacher.title': 'Teacher Management',
          'teacher.btn.add': 'Add Teacher',
          'teacher.tip.empty': 'No Data',

          // 班级管理页面
          'class.title': 'Class Management',
          'class.btn.add': 'Add Class',
          'class.tip.empty': 'No Data',
          'class.btn.reload': 'Reload',

          // 添加老师页面
          'add_teacher.title': 'Add Teacher',
          'add_teacher.form_data.name': 'Teacher Name',
          'add_teacher.form_data.name.hint': 'Please enter the teacher name',
          'add_teacher.form_data.en_name': 'English Name',
          'add_teacher.form_data.en_name.hint':
              'Please enter the teacher English name',
          'add_teacher.form_data.gender': 'Gender',
          'add_teacher.form_data.gender.hint':
              'Please select the teacher gender',
          'add_teacher.form_data.type': 'Type',
          'add_teacher.form_data.type.hint': 'Please select the teacher type',
          'add_teacher.form_data.dingtalk.login': 'Dingtalk Login',
          'add_teacher.form_data.btn.save': 'Save',
          'add_teacher.form_data.btn.saveAndBack': 'Save and Back',

          // 添加班级页面
          'add_class.title': 'Add Class',
          'add_class.form_data.name': 'Class Name',
          'add_class.form_data.name.hint': 'Please enter the class name',
          'add_class.form_data.teacher': 'Teacher',
          'add_class.form_data.teacher.hint': 'Please select the teacher',
          'add_class.form_data.btn.save': 'Save',
          'add_class.form_data.btn.saveAndBack': 'Save and Back',
          'add_class.form_data.icon': 'Class Icon',
          'add_class.form_data.icon.hint': 'Please select the class icon',

          // 班级详情页面
          'class_detail.title': 'Class Detail',
          'class_detail.init.failed': 'Get class detail failed',

          // 选择老师页面
          'choose_teacher.title': 'Choose Teacher',

          // 选择@用户页面
          'choose_at_users.title': 'Choose Remind Users',
          'choose_at_users.search': 'Search',
          'choose_at_users.confirm': 'Confirm',
          'choose_at_users.multi_select': 'Multi Select',
          'choose_at_users.multi_select.off': 'Cancel',
          'choose_at_users.at_all': 'All',

          // 发送机器人消息页面
          'send_robot_message.title': 'Send Robot Message',
          'send_robot_message.hint_text': 'Please enter the message content',
          'send_robot_message.load_more_message': 'Load More Message',
          'send_robot_message.no_more_message': 'No More Message',
          'send_robot_message.has_new_message': 'New Message',

          // 未登录页面
          'need_login.tip': 'Need Login',
          'need_login.btn.login': 'Dingtalk Authorization Login',

          // Toast
          'toast.login.success': 'Login Success',
          'toast.login.failed': 'Login Failed',
          'toast.logout.success': 'Logout Success',
          'toast.logout.failed': 'Logout Failed',
          'toast.add_teacher.name_required': 'Teacher name cannot be empty',
          'toast.add_teacher.en_name_required':
              'Teacher English name cannot be empty',
          'toast.add_teacher.save.success': 'Save Success',
          'toast.add_teacher.save.fail': 'Save Failed',
          'toast.refresh.success': 'Refresh Success',
          'toast.refresh.failed': 'Refresh Failed',
          'toast.add_class.name_required': 'Class name cannot be empty',
          'toast.add_class.save.success': 'Save Success',
          'toast.add_class.save.fail': 'Save Failed',

          // 加载更多
          'load_more.tips.no_more': 'No More Data',

          // 底部弹窗
          'bottom_sheet.choose_gender.title': 'Choose Gender',
          'bottom_sheet.choose_type.title': 'Choose Teacher Type',
          'bottom_sheet.choose_teacher.title': 'Choose Teacher',

          // 性别
          'gender.male': 'Male',
          'gender.female': 'Female',

          // 类型
          'type.full_time': 'Full-time Teacher',
          'type.part_time': 'Part-time Teacher',

          'teacher': 'Teacher',
          'student': 'Student',
          'schedule': 'Schedule',
          'notification': 'Notification',
        }
      };
}
