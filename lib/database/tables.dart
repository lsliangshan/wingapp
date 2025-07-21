import 'package:drift/drift.dart';
import 'package:intl/intl.dart';

@DataClassName('Teacher')
class Teachers extends Table {
  // 教师 ID、绑定钉钉的userid
  TextColumn get id => text()();
  // 钉钉的 unionId
  TextColumn get unionId => text().nullable()();
  // 钉钉的 openId
  TextColumn get openId => text().nullable()();

  /// 教师类型
  /// 1. full-time 全职老师
  /// 2. part-time 兼职老师
  TextColumn get type =>
      text().nullable().withDefault(const Constant('full-time'))();
  // 登录名
  TextColumn get username => text().nullable()();
  // 国家码
  TextColumn get stateCode =>
      text().nullable().withDefault(const Constant('86'))();
  // 手机号
  TextColumn get mobile => text().nullable()();
  // 邮箱
  TextColumn get email => text().nullable()();
  // 英文名称
  TextColumn get enName => text().nullable()();
  // 中文名称
  TextColumn get name => text().nullable()();
  // 头像
  TextColumn get avatar => text().nullable()();

  // 性别
  // male: 男
  // female: 女
  TextColumn get gender =>
      text().nullable().withDefault(const Constant('male'))();
  // 状态
  // active: 在职
  // inactive: 离职
  TextColumn get status =>
      text().nullable().withDefault(const Constant('active'))();
  // 是否是管理员，0 否，1 是
  TextColumn get admin => text().nullable().withDefault(const Constant('0'))();

  // 最后登录时间
  TextColumn get lastLoginTime => text().nullable().withDefault(
      Constant(DateTime.now().millisecondsSinceEpoch.toString()))();
  TextColumn get lastLoginIp => text().nullable()();
  TextColumn get birthday => text()
      .nullable()
      .withDefault(Constant(BigInt.from(1548720488000).toString()))();
  TextColumn get homepage => text().nullable()();
  TextColumn get token => text().nullable()();

  // 登录方式， google、github、emailAndPassword、usernameAndPassword、dingtalk
  TextColumn get loginType =>
      text().nullable().withDefault(const Constant('dingtalk'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Class')
class Classes extends Table {
  // 班级 ID
  TextColumn get id => text()();
  // 班级名称
  TextColumn get name => text().nullable()();
  // 班级图标
  TextColumn get icon => text().nullable()();
  // 班级老师 ID
  TextColumn get teacherId => text().nullable()();
  // 班级老师名称
  TextColumn get teacherName => text().nullable()();
  // 班级老师英文名称
  TextColumn get teacherEnName => text().nullable()();
  // 班级老师钉钉的 unionId
  TextColumn get teacherUnionId => text().nullable()();
  // 班级机器人编码
  TextColumn get robotCode => text().nullable()();
  // 班级机器人 openConversationId
  TextColumn get openConversationId => text().nullable()();
  // 班级机器人 chatId
  TextColumn get chatId => text().nullable()();
  // 班级机器人 link
  TextColumn get link => text().nullable()();
  // 班级机器人 assistant
  TextColumn get assistant => text().nullable()();
  // 班级创建时间
  TextColumn get createAt => text().nullable()();
  // 班级更新时间
  TextColumn get updateAt => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Message')
class Messages extends Table {
  // 消息 ID
  TextColumn get id => text()();
  // 班级 ID
  TextColumn get classId => text()();
  // 消息内容
  TextColumn get content => text()();
  // 消息发送者 ID
  TextColumn get senderId => text()();
  // 消息发送者名称
  TextColumn get senderName => text()();
  // 消息发送者头像
  TextColumn get senderAvatar =>
      text().nullable().withDefault(const Constant(''))();
  // 消息发送时间
  TextColumn get createAt => text().nullable().withDefault(
      Constant(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now())))();
  // 消息类型，text、image、voice、video
  TextColumn get type =>
      text().nullable().withDefault(const Constant('text'))();
  // 消息是否是机器人发送的
  BoolColumn get isRobot =>
      boolean().nullable().withDefault(const Constant(false))();
  // 消息来源，dingtalk、wingapp
  TextColumn get from =>
      text().nullable().withDefault(const Constant('dingtalk'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Student')
class Students extends Table {
  // 学生 ID、绑定钉钉的userid
  TextColumn get id => text()();
  // 钉钉的 unionId
  TextColumn get unionId => text().nullable()();
  // 钉钉的 openId
  TextColumn get openId => text().nullable()();

  // 登录名
  TextColumn get username => text().nullable()();
  // 国家码
  TextColumn get stateCode =>
      text().nullable().withDefault(const Constant('86'))();
  // 手机号
  TextColumn get mobile => text().nullable()();
  // 邮箱
  TextColumn get email => text().nullable()();
  // 英文名称
  TextColumn get enName => text().nullable()();
  // 中文名称
  TextColumn get name => text().nullable()();
  // 头像
  TextColumn get avatar => text().nullable()();

  // 性别
  // male: 男
  // female: 女
  TextColumn get gender =>
      text().nullable().withDefault(const Constant('male'))();
  // 学生状态
  // active: 在校
  // inactive: 离校
  TextColumn get status =>
      text().nullable().withDefault(const Constant('active'))();
  // 班级 ID
  TextColumn get classId => text().nullable()();
  // 老师 ID
  TextColumn get teacherId => text().nullable()();
  // 课程 ID
  TextColumn get courseId => text().nullable()();
  // 总课时
  TextColumn get totalSessions =>
      text().nullable().withDefault(const Constant('0'))();
  // 已上课时
  TextColumn get completedSessions =>
      text().nullable().withDefault(const Constant('0'))();

  // 最后登录时间
  TextColumn get lastLoginTime => text().nullable().withDefault(
      Constant(DateTime.now().millisecondsSinceEpoch.toString()))();
  TextColumn get lastLoginIp => text().nullable()();
  TextColumn get birthday => text()
      .nullable()
      .withDefault(Constant(BigInt.from(1548720488000).toString()))();
  TextColumn get homepage => text().nullable()();
  TextColumn get token => text().nullable()();

  // 登录方式， google、github、emailAndPassword、usernameAndPassword、dingtalk
  TextColumn get loginType =>
      text().nullable().withDefault(const Constant('dingtalk'))();

  @override
  Set<Column> get primaryKey => {id};
}

mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement().nullable()();
}
