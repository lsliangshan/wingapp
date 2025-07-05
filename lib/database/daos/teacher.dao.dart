import 'package:drift/drift.dart';
import 'package:wingapp/database/database.dart';
import 'package:wingapp/database/tables.dart';
import 'package:wingapp/models/login_info.model.dart';

part 'teacher.dao.g.dart';

@DriftAccessor(
    tables: [Teachers], queries: {'countAll': 'SELECT COUNT(*) FROM teachers;'})
class TeacherDao extends DatabaseAccessor<AppDatabase> with _$TeacherDaoMixin {
  // 构造方法是必需的，这样主数据库可以创建这个对象的实例。
  // ignore: use_super_parameters
  TeacherDao(AppDatabase db) : super(db);

  Future<int> createOrUpdateUser({
    required String id,
    String? unionId,
    String? openId,
    String? type,
    String? username,
    String? stateCode,
    String? mobile,
    String? email,
    String? enName,
    String? name,
    String? avatar,
    String? gender,
    String? status,
    String? admin,
    String? lastLoginTime,
    String? lastLoginIp,
    String? birthday,
    String? homepage,
    String? token,
    String? loginType,
  }) {
    return into(teachers).insertOnConflictUpdate(TeachersCompanion(
      id: Value(id),
      unionId: Value(unionId ?? ''),
      openId: Value(openId ?? ''),
      type: Value(type ?? ''),
      username: Value(username ?? ''),
      stateCode: Value(stateCode ?? ''),
      mobile: Value(mobile ?? ''),
      email: Value(email ?? ''),
      enName: Value(enName ?? ''),
      name: Value(name ?? ''),
      avatar: Value(avatar ?? ''),
      lastLoginTime: Value(lastLoginTime != null
          ? lastLoginTime.toString()
          : DateTime.now().millisecondsSinceEpoch.toString()),
      lastLoginIp: Value(lastLoginIp ?? ''),
      birthday: Value(birthday != null
          ? birthday.toString()
          : BigInt.from(1548720488000).toString()),
      homepage: Value(homepage ?? ''),
      token: Value(token ?? ''),
      gender: Value(gender ?? ''),
      status: Value(status ?? ''),
      admin: Value(admin ?? ''),
      loginType: Value(loginType ?? ''),
    ));
  }

  Future<Teacher?> login(Teacher user) async {
    Teacher? u = await (select(teachers)..where((tbl) => tbl.token.isNotNull()))
        .getSingleOrNull();
    if (u != null && u.id == user.id && u.token != '') {
      return u;
    }
    if (u != null) {
      await (update(teachers)..where((tbl) => tbl.id.equals(u.id))).write(
        const TeachersCompanion(
          token: Value(''),
        ),
      );
    }

    int id = await into(teachers).insert(TeachersCompanion(
      id: Value(user.id),
      unionId: Value(user.unionId),
      openId: Value(user.openId),
      type: Value(user.type),
      username: Value(user.username ?? ''),
      stateCode: Value(user.stateCode),
      mobile: Value(user.mobile),
      email: Value(user.email ?? ''),
      enName: Value(user.enName ?? ''),
      name: Value(user.name ?? ''),
      avatar: Value(user.avatar ?? ''),
      lastLoginTime: Value(user.lastLoginTime ?? ''),
      lastLoginIp: Value(user.lastLoginIp ?? ''),
      birthday: Value(user.birthday ?? ''),
      homepage: Value(user.homepage ?? ''),
      token: Value(user.token ?? ''),
      gender: Value(user.gender),
      status: Value(user.status),
      admin: Value(user.admin),
      loginType: Value(user.loginType),
    ));

    return (select(teachers)..where((tbl) => tbl.id.equals(user.id)))
        .getSingleOrNull();
  }

  Future<LoginInfo?> getLoginInfo() async {
    Teacher? u = await (select(teachers)..where((tbl) => tbl.token.isNotNull()))
        .getSingleOrNull();
    if (u == null) {
      return null;
    }
    return LoginInfo.fromJson(u.toJson());
  }

  Future<int> logout(String id) {
    return (delete(teachers)..where((u) => u.id.equals(id))).go();
  }

  Future<int> updateUser({
    required String id,
    String? unionId,
    String? openId,
    String? mobile,
    String? email,
    String? avatar,
    String? name,
    String? enName,
    String? gender,
    String? type,
    String? status,
  }) {
    TeachersCompanion companion = const TeachersCompanion();
    if (unionId != null) {
      companion = companion.copyWith(unionId: Value(unionId));
    }
    if (openId != null) {
      companion = companion.copyWith(openId: Value(openId));
    }
    if (mobile != null) {
      companion = companion.copyWith(mobile: Value(mobile));
    }
    if (email != null) {
      companion = companion.copyWith(email: Value(email));
    }
    if (avatar != null) {
      companion = companion.copyWith(avatar: Value(avatar));
    }
    if (name != null) {
      companion = companion.copyWith(name: Value(name));
    }
    if (status != null) {
      companion = companion.copyWith(status: Value(status));
    }
    if (gender != null) {
      companion = companion.copyWith(gender: Value(gender));
    }
    if (enName != null) {
      companion = companion.copyWith(enName: Value(enName));
    }
    if (type != null) {
      companion = companion.copyWith(type: Value(type));
    }

    return (update(teachers)..where((u) => u.id.equals(id))).write(companion);
  }
}
