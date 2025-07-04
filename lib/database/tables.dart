import 'package:drift/drift.dart';

@DataClassName('Teacher')
class Teachers extends Table {
  // 教师 ID、绑定钉钉的userid
  TextColumn get id => text()();
  // 钉钉的 unionId
  TextColumn get unionId => text()();
  // 钉钉的 openId
  TextColumn get openId => text()();

  /// 教师类型
  /// 1. full-time 全职老师
  /// 2. part-time 兼职老师
  TextColumn get type => text()();
  // 登录名
  TextColumn get username => text().nullable()();
  // 国家码
  TextColumn get stateCode => text().withDefault(const Constant('86'))();
  // 手机号
  TextColumn get mobile => text()();
  // 邮箱
  TextColumn get email => text().nullable()();
  // 英文名称
  TextColumn get enName => text().nullable()();
  // 中文名称
  TextColumn get name => text().nullable()();
  // 头像
  TextColumn get avatar => text().nullable()();

  // 性别，男、女
  TextColumn get gender => text().withDefault(const Constant('男'))();
  // 状态，在职、离职
  TextColumn get status => text().withDefault(const Constant('在职'))();
  // 是否是管理员，0 否，1 是
  TextColumn get admin => text().withDefault(const Constant('0'))();

  // 最后登录时间
  Int64Column get lastLoginTime => int64().withDefault(
      Constant(BigInt.from(DateTime.now().millisecondsSinceEpoch)))();
  TextColumn get lastLoginIp => text().nullable()();
  Int64Column get birthday =>
      int64().withDefault(Constant(BigInt.from(1548720488000)))();
  TextColumn get homepage => text().nullable()();
  TextColumn get token => text()();

  // 登录方式， google、github、emailAndPassword、usernameAndPassword、dingtalk
  TextColumn get loginType => text().withDefault(const Constant('dingtalk'))();
}

mixin AutoIncrementingPrimaryKey on Table {
  IntColumn get id => integer().autoIncrement().nullable()();
}
