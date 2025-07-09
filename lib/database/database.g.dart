// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $TeachersTable extends Teachers with TableInfo<$TeachersTable, Teacher> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TeachersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unionIdMeta =
      const VerificationMeta('unionId');
  @override
  late final GeneratedColumn<String> unionId = GeneratedColumn<String>(
      'union_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _openIdMeta = const VerificationMeta('openId');
  @override
  late final GeneratedColumn<String> openId = GeneratedColumn<String>(
      'open_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('全职老师'));
  static const VerificationMeta _usernameMeta =
      const VerificationMeta('username');
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
      'username', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _stateCodeMeta =
      const VerificationMeta('stateCode');
  @override
  late final GeneratedColumn<String> stateCode = GeneratedColumn<String>(
      'state_code', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('86'));
  static const VerificationMeta _mobileMeta = const VerificationMeta('mobile');
  @override
  late final GeneratedColumn<String> mobile = GeneratedColumn<String>(
      'mobile', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _enNameMeta = const VerificationMeta('enName');
  @override
  late final GeneratedColumn<String> enName = GeneratedColumn<String>(
      'en_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
      'avatar', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('男'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('在职'));
  static const VerificationMeta _adminMeta = const VerificationMeta('admin');
  @override
  late final GeneratedColumn<String> admin = GeneratedColumn<String>(
      'admin', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('0'));
  static const VerificationMeta _lastLoginTimeMeta =
      const VerificationMeta('lastLoginTime');
  @override
  late final GeneratedColumn<String> lastLoginTime = GeneratedColumn<String>(
      'last_login_time', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(DateTime.now().millisecondsSinceEpoch.toString()));
  static const VerificationMeta _lastLoginIpMeta =
      const VerificationMeta('lastLoginIp');
  @override
  late final GeneratedColumn<String> lastLoginIp = GeneratedColumn<String>(
      'last_login_ip', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<String> birthday = GeneratedColumn<String>(
      'birthday', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: Constant(BigInt.from(1548720488000).toString()));
  static const VerificationMeta _homepageMeta =
      const VerificationMeta('homepage');
  @override
  late final GeneratedColumn<String> homepage = GeneratedColumn<String>(
      'homepage', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
      'token', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _loginTypeMeta =
      const VerificationMeta('loginType');
  @override
  late final GeneratedColumn<String> loginType = GeneratedColumn<String>(
      'login_type', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('dingtalk'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        unionId,
        openId,
        type,
        username,
        stateCode,
        mobile,
        email,
        enName,
        name,
        avatar,
        gender,
        status,
        admin,
        lastLoginTime,
        lastLoginIp,
        birthday,
        homepage,
        token,
        loginType
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'teachers';
  @override
  VerificationContext validateIntegrity(Insertable<Teacher> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('union_id')) {
      context.handle(_unionIdMeta,
          unionId.isAcceptableOrUnknown(data['union_id']!, _unionIdMeta));
    } else if (isInserting) {
      context.missing(_unionIdMeta);
    }
    if (data.containsKey('open_id')) {
      context.handle(_openIdMeta,
          openId.isAcceptableOrUnknown(data['open_id']!, _openIdMeta));
    } else if (isInserting) {
      context.missing(_openIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('username')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['username']!, _usernameMeta));
    }
    if (data.containsKey('state_code')) {
      context.handle(_stateCodeMeta,
          stateCode.isAcceptableOrUnknown(data['state_code']!, _stateCodeMeta));
    }
    if (data.containsKey('mobile')) {
      context.handle(_mobileMeta,
          mobile.isAcceptableOrUnknown(data['mobile']!, _mobileMeta));
    } else if (isInserting) {
      context.missing(_mobileMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('en_name')) {
      context.handle(_enNameMeta,
          enName.isAcceptableOrUnknown(data['en_name']!, _enNameMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    }
    if (data.containsKey('avatar')) {
      context.handle(_avatarMeta,
          avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('admin')) {
      context.handle(
          _adminMeta, admin.isAcceptableOrUnknown(data['admin']!, _adminMeta));
    }
    if (data.containsKey('last_login_time')) {
      context.handle(
          _lastLoginTimeMeta,
          lastLoginTime.isAcceptableOrUnknown(
              data['last_login_time']!, _lastLoginTimeMeta));
    }
    if (data.containsKey('last_login_ip')) {
      context.handle(
          _lastLoginIpMeta,
          lastLoginIp.isAcceptableOrUnknown(
              data['last_login_ip']!, _lastLoginIpMeta));
    }
    if (data.containsKey('birthday')) {
      context.handle(_birthdayMeta,
          birthday.isAcceptableOrUnknown(data['birthday']!, _birthdayMeta));
    }
    if (data.containsKey('homepage')) {
      context.handle(_homepageMeta,
          homepage.isAcceptableOrUnknown(data['homepage']!, _homepageMeta));
    }
    if (data.containsKey('token')) {
      context.handle(
          _tokenMeta, token.isAcceptableOrUnknown(data['token']!, _tokenMeta));
    }
    if (data.containsKey('login_type')) {
      context.handle(_loginTypeMeta,
          loginType.isAcceptableOrUnknown(data['login_type']!, _loginTypeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Teacher map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Teacher(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      unionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}union_id'])!,
      openId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}open_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type']),
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      stateCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state_code']),
      mobile: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mobile'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      enName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}en_name']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name']),
      avatar: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}avatar']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status']),
      admin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}admin']),
      lastLoginTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_login_time']),
      lastLoginIp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_login_ip']),
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}birthday']),
      homepage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}homepage']),
      token: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}token']),
      loginType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}login_type']),
    );
  }

  @override
  $TeachersTable createAlias(String alias) {
    return $TeachersTable(attachedDatabase, alias);
  }
}

class Teacher extends DataClass implements Insertable<Teacher> {
  final String id;
  final String unionId;
  final String openId;

  /// 教师类型
  /// 1. full-time 全职老师
  /// 2. part-time 兼职老师
  final String? type;
  final String? username;
  final String? stateCode;
  final String mobile;
  final String? email;
  final String? enName;
  final String? name;
  final String? avatar;
  final String? gender;
  final String? status;
  final String? admin;
  final String? lastLoginTime;
  final String? lastLoginIp;
  final String? birthday;
  final String? homepage;
  final String? token;
  final String? loginType;
  const Teacher(
      {required this.id,
      required this.unionId,
      required this.openId,
      this.type,
      this.username,
      this.stateCode,
      required this.mobile,
      this.email,
      this.enName,
      this.name,
      this.avatar,
      this.gender,
      this.status,
      this.admin,
      this.lastLoginTime,
      this.lastLoginIp,
      this.birthday,
      this.homepage,
      this.token,
      this.loginType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['union_id'] = Variable<String>(unionId);
    map['open_id'] = Variable<String>(openId);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    if (!nullToAbsent || stateCode != null) {
      map['state_code'] = Variable<String>(stateCode);
    }
    map['mobile'] = Variable<String>(mobile);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || enName != null) {
      map['en_name'] = Variable<String>(enName);
    }
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || status != null) {
      map['status'] = Variable<String>(status);
    }
    if (!nullToAbsent || admin != null) {
      map['admin'] = Variable<String>(admin);
    }
    if (!nullToAbsent || lastLoginTime != null) {
      map['last_login_time'] = Variable<String>(lastLoginTime);
    }
    if (!nullToAbsent || lastLoginIp != null) {
      map['last_login_ip'] = Variable<String>(lastLoginIp);
    }
    if (!nullToAbsent || birthday != null) {
      map['birthday'] = Variable<String>(birthday);
    }
    if (!nullToAbsent || homepage != null) {
      map['homepage'] = Variable<String>(homepage);
    }
    if (!nullToAbsent || token != null) {
      map['token'] = Variable<String>(token);
    }
    if (!nullToAbsent || loginType != null) {
      map['login_type'] = Variable<String>(loginType);
    }
    return map;
  }

  TeachersCompanion toCompanion(bool nullToAbsent) {
    return TeachersCompanion(
      id: Value(id),
      unionId: Value(unionId),
      openId: Value(openId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      stateCode: stateCode == null && nullToAbsent
          ? const Value.absent()
          : Value(stateCode),
      mobile: Value(mobile),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      enName:
          enName == null && nullToAbsent ? const Value.absent() : Value(enName),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      status:
          status == null && nullToAbsent ? const Value.absent() : Value(status),
      admin:
          admin == null && nullToAbsent ? const Value.absent() : Value(admin),
      lastLoginTime: lastLoginTime == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginTime),
      lastLoginIp: lastLoginIp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginIp),
      birthday: birthday == null && nullToAbsent
          ? const Value.absent()
          : Value(birthday),
      homepage: homepage == null && nullToAbsent
          ? const Value.absent()
          : Value(homepage),
      token:
          token == null && nullToAbsent ? const Value.absent() : Value(token),
      loginType: loginType == null && nullToAbsent
          ? const Value.absent()
          : Value(loginType),
    );
  }

  factory Teacher.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Teacher(
      id: serializer.fromJson<String>(json['id']),
      unionId: serializer.fromJson<String>(json['unionId']),
      openId: serializer.fromJson<String>(json['openId']),
      type: serializer.fromJson<String?>(json['type']),
      username: serializer.fromJson<String?>(json['username']),
      stateCode: serializer.fromJson<String?>(json['stateCode']),
      mobile: serializer.fromJson<String>(json['mobile']),
      email: serializer.fromJson<String?>(json['email']),
      enName: serializer.fromJson<String?>(json['enName']),
      name: serializer.fromJson<String?>(json['name']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      gender: serializer.fromJson<String?>(json['gender']),
      status: serializer.fromJson<String?>(json['status']),
      admin: serializer.fromJson<String?>(json['admin']),
      lastLoginTime: serializer.fromJson<String?>(json['lastLoginTime']),
      lastLoginIp: serializer.fromJson<String?>(json['lastLoginIp']),
      birthday: serializer.fromJson<String?>(json['birthday']),
      homepage: serializer.fromJson<String?>(json['homepage']),
      token: serializer.fromJson<String?>(json['token']),
      loginType: serializer.fromJson<String?>(json['loginType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unionId': serializer.toJson<String>(unionId),
      'openId': serializer.toJson<String>(openId),
      'type': serializer.toJson<String?>(type),
      'username': serializer.toJson<String?>(username),
      'stateCode': serializer.toJson<String?>(stateCode),
      'mobile': serializer.toJson<String>(mobile),
      'email': serializer.toJson<String?>(email),
      'enName': serializer.toJson<String?>(enName),
      'name': serializer.toJson<String?>(name),
      'avatar': serializer.toJson<String?>(avatar),
      'gender': serializer.toJson<String?>(gender),
      'status': serializer.toJson<String?>(status),
      'admin': serializer.toJson<String?>(admin),
      'lastLoginTime': serializer.toJson<String?>(lastLoginTime),
      'lastLoginIp': serializer.toJson<String?>(lastLoginIp),
      'birthday': serializer.toJson<String?>(birthday),
      'homepage': serializer.toJson<String?>(homepage),
      'token': serializer.toJson<String?>(token),
      'loginType': serializer.toJson<String?>(loginType),
    };
  }

  Teacher copyWith(
          {String? id,
          String? unionId,
          String? openId,
          Value<String?> type = const Value.absent(),
          Value<String?> username = const Value.absent(),
          Value<String?> stateCode = const Value.absent(),
          String? mobile,
          Value<String?> email = const Value.absent(),
          Value<String?> enName = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<String?> avatar = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          Value<String?> status = const Value.absent(),
          Value<String?> admin = const Value.absent(),
          Value<String?> lastLoginTime = const Value.absent(),
          Value<String?> lastLoginIp = const Value.absent(),
          Value<String?> birthday = const Value.absent(),
          Value<String?> homepage = const Value.absent(),
          Value<String?> token = const Value.absent(),
          Value<String?> loginType = const Value.absent()}) =>
      Teacher(
        id: id ?? this.id,
        unionId: unionId ?? this.unionId,
        openId: openId ?? this.openId,
        type: type.present ? type.value : this.type,
        username: username.present ? username.value : this.username,
        stateCode: stateCode.present ? stateCode.value : this.stateCode,
        mobile: mobile ?? this.mobile,
        email: email.present ? email.value : this.email,
        enName: enName.present ? enName.value : this.enName,
        name: name.present ? name.value : this.name,
        avatar: avatar.present ? avatar.value : this.avatar,
        gender: gender.present ? gender.value : this.gender,
        status: status.present ? status.value : this.status,
        admin: admin.present ? admin.value : this.admin,
        lastLoginTime:
            lastLoginTime.present ? lastLoginTime.value : this.lastLoginTime,
        lastLoginIp: lastLoginIp.present ? lastLoginIp.value : this.lastLoginIp,
        birthday: birthday.present ? birthday.value : this.birthday,
        homepage: homepage.present ? homepage.value : this.homepage,
        token: token.present ? token.value : this.token,
        loginType: loginType.present ? loginType.value : this.loginType,
      );
  Teacher copyWithCompanion(TeachersCompanion data) {
    return Teacher(
      id: data.id.present ? data.id.value : this.id,
      unionId: data.unionId.present ? data.unionId.value : this.unionId,
      openId: data.openId.present ? data.openId.value : this.openId,
      type: data.type.present ? data.type.value : this.type,
      username: data.username.present ? data.username.value : this.username,
      stateCode: data.stateCode.present ? data.stateCode.value : this.stateCode,
      mobile: data.mobile.present ? data.mobile.value : this.mobile,
      email: data.email.present ? data.email.value : this.email,
      enName: data.enName.present ? data.enName.value : this.enName,
      name: data.name.present ? data.name.value : this.name,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      gender: data.gender.present ? data.gender.value : this.gender,
      status: data.status.present ? data.status.value : this.status,
      admin: data.admin.present ? data.admin.value : this.admin,
      lastLoginTime: data.lastLoginTime.present
          ? data.lastLoginTime.value
          : this.lastLoginTime,
      lastLoginIp:
          data.lastLoginIp.present ? data.lastLoginIp.value : this.lastLoginIp,
      birthday: data.birthday.present ? data.birthday.value : this.birthday,
      homepage: data.homepage.present ? data.homepage.value : this.homepage,
      token: data.token.present ? data.token.value : this.token,
      loginType: data.loginType.present ? data.loginType.value : this.loginType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Teacher(')
          ..write('id: $id, ')
          ..write('unionId: $unionId, ')
          ..write('openId: $openId, ')
          ..write('type: $type, ')
          ..write('username: $username, ')
          ..write('stateCode: $stateCode, ')
          ..write('mobile: $mobile, ')
          ..write('email: $email, ')
          ..write('enName: $enName, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('status: $status, ')
          ..write('admin: $admin, ')
          ..write('lastLoginTime: $lastLoginTime, ')
          ..write('lastLoginIp: $lastLoginIp, ')
          ..write('birthday: $birthday, ')
          ..write('homepage: $homepage, ')
          ..write('token: $token, ')
          ..write('loginType: $loginType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      unionId,
      openId,
      type,
      username,
      stateCode,
      mobile,
      email,
      enName,
      name,
      avatar,
      gender,
      status,
      admin,
      lastLoginTime,
      lastLoginIp,
      birthday,
      homepage,
      token,
      loginType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Teacher &&
          other.id == this.id &&
          other.unionId == this.unionId &&
          other.openId == this.openId &&
          other.type == this.type &&
          other.username == this.username &&
          other.stateCode == this.stateCode &&
          other.mobile == this.mobile &&
          other.email == this.email &&
          other.enName == this.enName &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.gender == this.gender &&
          other.status == this.status &&
          other.admin == this.admin &&
          other.lastLoginTime == this.lastLoginTime &&
          other.lastLoginIp == this.lastLoginIp &&
          other.birthday == this.birthday &&
          other.homepage == this.homepage &&
          other.token == this.token &&
          other.loginType == this.loginType);
}

class TeachersCompanion extends UpdateCompanion<Teacher> {
  final Value<String> id;
  final Value<String> unionId;
  final Value<String> openId;
  final Value<String?> type;
  final Value<String?> username;
  final Value<String?> stateCode;
  final Value<String> mobile;
  final Value<String?> email;
  final Value<String?> enName;
  final Value<String?> name;
  final Value<String?> avatar;
  final Value<String?> gender;
  final Value<String?> status;
  final Value<String?> admin;
  final Value<String?> lastLoginTime;
  final Value<String?> lastLoginIp;
  final Value<String?> birthday;
  final Value<String?> homepage;
  final Value<String?> token;
  final Value<String?> loginType;
  final Value<int> rowid;
  const TeachersCompanion({
    this.id = const Value.absent(),
    this.unionId = const Value.absent(),
    this.openId = const Value.absent(),
    this.type = const Value.absent(),
    this.username = const Value.absent(),
    this.stateCode = const Value.absent(),
    this.mobile = const Value.absent(),
    this.email = const Value.absent(),
    this.enName = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.gender = const Value.absent(),
    this.status = const Value.absent(),
    this.admin = const Value.absent(),
    this.lastLoginTime = const Value.absent(),
    this.lastLoginIp = const Value.absent(),
    this.birthday = const Value.absent(),
    this.homepage = const Value.absent(),
    this.token = const Value.absent(),
    this.loginType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TeachersCompanion.insert({
    required String id,
    required String unionId,
    required String openId,
    this.type = const Value.absent(),
    this.username = const Value.absent(),
    this.stateCode = const Value.absent(),
    required String mobile,
    this.email = const Value.absent(),
    this.enName = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.gender = const Value.absent(),
    this.status = const Value.absent(),
    this.admin = const Value.absent(),
    this.lastLoginTime = const Value.absent(),
    this.lastLoginIp = const Value.absent(),
    this.birthday = const Value.absent(),
    this.homepage = const Value.absent(),
    this.token = const Value.absent(),
    this.loginType = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        unionId = Value(unionId),
        openId = Value(openId),
        mobile = Value(mobile);
  static Insertable<Teacher> custom({
    Expression<String>? id,
    Expression<String>? unionId,
    Expression<String>? openId,
    Expression<String>? type,
    Expression<String>? username,
    Expression<String>? stateCode,
    Expression<String>? mobile,
    Expression<String>? email,
    Expression<String>? enName,
    Expression<String>? name,
    Expression<String>? avatar,
    Expression<String>? gender,
    Expression<String>? status,
    Expression<String>? admin,
    Expression<String>? lastLoginTime,
    Expression<String>? lastLoginIp,
    Expression<String>? birthday,
    Expression<String>? homepage,
    Expression<String>? token,
    Expression<String>? loginType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (unionId != null) 'union_id': unionId,
      if (openId != null) 'open_id': openId,
      if (type != null) 'type': type,
      if (username != null) 'username': username,
      if (stateCode != null) 'state_code': stateCode,
      if (mobile != null) 'mobile': mobile,
      if (email != null) 'email': email,
      if (enName != null) 'en_name': enName,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (gender != null) 'gender': gender,
      if (status != null) 'status': status,
      if (admin != null) 'admin': admin,
      if (lastLoginTime != null) 'last_login_time': lastLoginTime,
      if (lastLoginIp != null) 'last_login_ip': lastLoginIp,
      if (birthday != null) 'birthday': birthday,
      if (homepage != null) 'homepage': homepage,
      if (token != null) 'token': token,
      if (loginType != null) 'login_type': loginType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TeachersCompanion copyWith(
      {Value<String>? id,
      Value<String>? unionId,
      Value<String>? openId,
      Value<String?>? type,
      Value<String?>? username,
      Value<String?>? stateCode,
      Value<String>? mobile,
      Value<String?>? email,
      Value<String?>? enName,
      Value<String?>? name,
      Value<String?>? avatar,
      Value<String?>? gender,
      Value<String?>? status,
      Value<String?>? admin,
      Value<String?>? lastLoginTime,
      Value<String?>? lastLoginIp,
      Value<String?>? birthday,
      Value<String?>? homepage,
      Value<String?>? token,
      Value<String?>? loginType,
      Value<int>? rowid}) {
    return TeachersCompanion(
      id: id ?? this.id,
      unionId: unionId ?? this.unionId,
      openId: openId ?? this.openId,
      type: type ?? this.type,
      username: username ?? this.username,
      stateCode: stateCode ?? this.stateCode,
      mobile: mobile ?? this.mobile,
      email: email ?? this.email,
      enName: enName ?? this.enName,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      gender: gender ?? this.gender,
      status: status ?? this.status,
      admin: admin ?? this.admin,
      lastLoginTime: lastLoginTime ?? this.lastLoginTime,
      lastLoginIp: lastLoginIp ?? this.lastLoginIp,
      birthday: birthday ?? this.birthday,
      homepage: homepage ?? this.homepage,
      token: token ?? this.token,
      loginType: loginType ?? this.loginType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (unionId.present) {
      map['union_id'] = Variable<String>(unionId.value);
    }
    if (openId.present) {
      map['open_id'] = Variable<String>(openId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (stateCode.present) {
      map['state_code'] = Variable<String>(stateCode.value);
    }
    if (mobile.present) {
      map['mobile'] = Variable<String>(mobile.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (enName.present) {
      map['en_name'] = Variable<String>(enName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (admin.present) {
      map['admin'] = Variable<String>(admin.value);
    }
    if (lastLoginTime.present) {
      map['last_login_time'] = Variable<String>(lastLoginTime.value);
    }
    if (lastLoginIp.present) {
      map['last_login_ip'] = Variable<String>(lastLoginIp.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<String>(birthday.value);
    }
    if (homepage.present) {
      map['homepage'] = Variable<String>(homepage.value);
    }
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (loginType.present) {
      map['login_type'] = Variable<String>(loginType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TeachersCompanion(')
          ..write('id: $id, ')
          ..write('unionId: $unionId, ')
          ..write('openId: $openId, ')
          ..write('type: $type, ')
          ..write('username: $username, ')
          ..write('stateCode: $stateCode, ')
          ..write('mobile: $mobile, ')
          ..write('email: $email, ')
          ..write('enName: $enName, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('gender: $gender, ')
          ..write('status: $status, ')
          ..write('admin: $admin, ')
          ..write('lastLoginTime: $lastLoginTime, ')
          ..write('lastLoginIp: $lastLoginIp, ')
          ..write('birthday: $birthday, ')
          ..write('homepage: $homepage, ')
          ..write('token: $token, ')
          ..write('loginType: $loginType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClassesTable extends Classes with TableInfo<$ClassesTable, Class> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
      'icon', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _teacherIdMeta =
      const VerificationMeta('teacherId');
  @override
  late final GeneratedColumn<String> teacherId = GeneratedColumn<String>(
      'teacher_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _teacherNameMeta =
      const VerificationMeta('teacherName');
  @override
  late final GeneratedColumn<String> teacherName = GeneratedColumn<String>(
      'teacher_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _teacherEnNameMeta =
      const VerificationMeta('teacherEnName');
  @override
  late final GeneratedColumn<String> teacherEnName = GeneratedColumn<String>(
      'teacher_en_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _teacherUnionIdMeta =
      const VerificationMeta('teacherUnionId');
  @override
  late final GeneratedColumn<String> teacherUnionId = GeneratedColumn<String>(
      'teacher_union_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _robotCodeMeta =
      const VerificationMeta('robotCode');
  @override
  late final GeneratedColumn<String> robotCode = GeneratedColumn<String>(
      'robot_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _openConversationIdMeta =
      const VerificationMeta('openConversationId');
  @override
  late final GeneratedColumn<String> openConversationId =
      GeneratedColumn<String>('open_conversation_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _chatIdMeta = const VerificationMeta('chatId');
  @override
  late final GeneratedColumn<String> chatId = GeneratedColumn<String>(
      'chat_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
      'link', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _assistantMeta =
      const VerificationMeta('assistant');
  @override
  late final GeneratedColumn<String> assistant = GeneratedColumn<String>(
      'assistant', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createAtMeta =
      const VerificationMeta('createAt');
  @override
  late final GeneratedColumn<String> createAt = GeneratedColumn<String>(
      'create_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _updateAtMeta =
      const VerificationMeta('updateAt');
  @override
  late final GeneratedColumn<String> updateAt = GeneratedColumn<String>(
      'update_at', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        icon,
        teacherId,
        teacherName,
        teacherEnName,
        teacherUnionId,
        robotCode,
        openConversationId,
        chatId,
        link,
        assistant,
        createAt,
        updateAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'classes';
  @override
  VerificationContext validateIntegrity(Insertable<Class> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    }
    if (data.containsKey('teacher_id')) {
      context.handle(_teacherIdMeta,
          teacherId.isAcceptableOrUnknown(data['teacher_id']!, _teacherIdMeta));
    }
    if (data.containsKey('teacher_name')) {
      context.handle(
          _teacherNameMeta,
          teacherName.isAcceptableOrUnknown(
              data['teacher_name']!, _teacherNameMeta));
    }
    if (data.containsKey('teacher_en_name')) {
      context.handle(
          _teacherEnNameMeta,
          teacherEnName.isAcceptableOrUnknown(
              data['teacher_en_name']!, _teacherEnNameMeta));
    }
    if (data.containsKey('teacher_union_id')) {
      context.handle(
          _teacherUnionIdMeta,
          teacherUnionId.isAcceptableOrUnknown(
              data['teacher_union_id']!, _teacherUnionIdMeta));
    }
    if (data.containsKey('robot_code')) {
      context.handle(_robotCodeMeta,
          robotCode.isAcceptableOrUnknown(data['robot_code']!, _robotCodeMeta));
    }
    if (data.containsKey('open_conversation_id')) {
      context.handle(
          _openConversationIdMeta,
          openConversationId.isAcceptableOrUnknown(
              data['open_conversation_id']!, _openConversationIdMeta));
    }
    if (data.containsKey('chat_id')) {
      context.handle(_chatIdMeta,
          chatId.isAcceptableOrUnknown(data['chat_id']!, _chatIdMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
          _linkMeta, link.isAcceptableOrUnknown(data['link']!, _linkMeta));
    }
    if (data.containsKey('assistant')) {
      context.handle(_assistantMeta,
          assistant.isAcceptableOrUnknown(data['assistant']!, _assistantMeta));
    }
    if (data.containsKey('create_at')) {
      context.handle(_createAtMeta,
          createAt.isAcceptableOrUnknown(data['create_at']!, _createAtMeta));
    }
    if (data.containsKey('update_at')) {
      context.handle(_updateAtMeta,
          updateAt.isAcceptableOrUnknown(data['update_at']!, _updateAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Class map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Class(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}icon']),
      teacherId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}teacher_id']),
      teacherName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}teacher_name']),
      teacherEnName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}teacher_en_name']),
      teacherUnionId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}teacher_union_id']),
      robotCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}robot_code']),
      openConversationId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}open_conversation_id']),
      chatId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}chat_id']),
      link: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}link']),
      assistant: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}assistant']),
      createAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}create_at']),
      updateAt: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}update_at']),
    );
  }

  @override
  $ClassesTable createAlias(String alias) {
    return $ClassesTable(attachedDatabase, alias);
  }
}

class Class extends DataClass implements Insertable<Class> {
  final String id;
  final String name;
  final String? icon;
  final String? teacherId;
  final String? teacherName;
  final String? teacherEnName;
  final String? teacherUnionId;
  final String? robotCode;
  final String? openConversationId;
  final String? chatId;
  final String? link;
  final String? assistant;
  final String? createAt;
  final String? updateAt;
  const Class(
      {required this.id,
      required this.name,
      this.icon,
      this.teacherId,
      this.teacherName,
      this.teacherEnName,
      this.teacherUnionId,
      this.robotCode,
      this.openConversationId,
      this.chatId,
      this.link,
      this.assistant,
      this.createAt,
      this.updateAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    if (!nullToAbsent || teacherId != null) {
      map['teacher_id'] = Variable<String>(teacherId);
    }
    if (!nullToAbsent || teacherName != null) {
      map['teacher_name'] = Variable<String>(teacherName);
    }
    if (!nullToAbsent || teacherEnName != null) {
      map['teacher_en_name'] = Variable<String>(teacherEnName);
    }
    if (!nullToAbsent || teacherUnionId != null) {
      map['teacher_union_id'] = Variable<String>(teacherUnionId);
    }
    if (!nullToAbsent || robotCode != null) {
      map['robot_code'] = Variable<String>(robotCode);
    }
    if (!nullToAbsent || openConversationId != null) {
      map['open_conversation_id'] = Variable<String>(openConversationId);
    }
    if (!nullToAbsent || chatId != null) {
      map['chat_id'] = Variable<String>(chatId);
    }
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    if (!nullToAbsent || assistant != null) {
      map['assistant'] = Variable<String>(assistant);
    }
    if (!nullToAbsent || createAt != null) {
      map['create_at'] = Variable<String>(createAt);
    }
    if (!nullToAbsent || updateAt != null) {
      map['update_at'] = Variable<String>(updateAt);
    }
    return map;
  }

  ClassesCompanion toCompanion(bool nullToAbsent) {
    return ClassesCompanion(
      id: Value(id),
      name: Value(name),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      teacherId: teacherId == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherId),
      teacherName: teacherName == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherName),
      teacherEnName: teacherEnName == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherEnName),
      teacherUnionId: teacherUnionId == null && nullToAbsent
          ? const Value.absent()
          : Value(teacherUnionId),
      robotCode: robotCode == null && nullToAbsent
          ? const Value.absent()
          : Value(robotCode),
      openConversationId: openConversationId == null && nullToAbsent
          ? const Value.absent()
          : Value(openConversationId),
      chatId:
          chatId == null && nullToAbsent ? const Value.absent() : Value(chatId),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
      assistant: assistant == null && nullToAbsent
          ? const Value.absent()
          : Value(assistant),
      createAt: createAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createAt),
      updateAt: updateAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updateAt),
    );
  }

  factory Class.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Class(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<String?>(json['icon']),
      teacherId: serializer.fromJson<String?>(json['teacherId']),
      teacherName: serializer.fromJson<String?>(json['teacherName']),
      teacherEnName: serializer.fromJson<String?>(json['teacherEnName']),
      teacherUnionId: serializer.fromJson<String?>(json['teacherUnionId']),
      robotCode: serializer.fromJson<String?>(json['robotCode']),
      openConversationId:
          serializer.fromJson<String?>(json['openConversationId']),
      chatId: serializer.fromJson<String?>(json['chatId']),
      link: serializer.fromJson<String?>(json['link']),
      assistant: serializer.fromJson<String?>(json['assistant']),
      createAt: serializer.fromJson<String?>(json['createAt']),
      updateAt: serializer.fromJson<String?>(json['updateAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<String?>(icon),
      'teacherId': serializer.toJson<String?>(teacherId),
      'teacherName': serializer.toJson<String?>(teacherName),
      'teacherEnName': serializer.toJson<String?>(teacherEnName),
      'teacherUnionId': serializer.toJson<String?>(teacherUnionId),
      'robotCode': serializer.toJson<String?>(robotCode),
      'openConversationId': serializer.toJson<String?>(openConversationId),
      'chatId': serializer.toJson<String?>(chatId),
      'link': serializer.toJson<String?>(link),
      'assistant': serializer.toJson<String?>(assistant),
      'createAt': serializer.toJson<String?>(createAt),
      'updateAt': serializer.toJson<String?>(updateAt),
    };
  }

  Class copyWith(
          {String? id,
          String? name,
          Value<String?> icon = const Value.absent(),
          Value<String?> teacherId = const Value.absent(),
          Value<String?> teacherName = const Value.absent(),
          Value<String?> teacherEnName = const Value.absent(),
          Value<String?> teacherUnionId = const Value.absent(),
          Value<String?> robotCode = const Value.absent(),
          Value<String?> openConversationId = const Value.absent(),
          Value<String?> chatId = const Value.absent(),
          Value<String?> link = const Value.absent(),
          Value<String?> assistant = const Value.absent(),
          Value<String?> createAt = const Value.absent(),
          Value<String?> updateAt = const Value.absent()}) =>
      Class(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon.present ? icon.value : this.icon,
        teacherId: teacherId.present ? teacherId.value : this.teacherId,
        teacherName: teacherName.present ? teacherName.value : this.teacherName,
        teacherEnName:
            teacherEnName.present ? teacherEnName.value : this.teacherEnName,
        teacherUnionId:
            teacherUnionId.present ? teacherUnionId.value : this.teacherUnionId,
        robotCode: robotCode.present ? robotCode.value : this.robotCode,
        openConversationId: openConversationId.present
            ? openConversationId.value
            : this.openConversationId,
        chatId: chatId.present ? chatId.value : this.chatId,
        link: link.present ? link.value : this.link,
        assistant: assistant.present ? assistant.value : this.assistant,
        createAt: createAt.present ? createAt.value : this.createAt,
        updateAt: updateAt.present ? updateAt.value : this.updateAt,
      );
  Class copyWithCompanion(ClassesCompanion data) {
    return Class(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      icon: data.icon.present ? data.icon.value : this.icon,
      teacherId: data.teacherId.present ? data.teacherId.value : this.teacherId,
      teacherName:
          data.teacherName.present ? data.teacherName.value : this.teacherName,
      teacherEnName: data.teacherEnName.present
          ? data.teacherEnName.value
          : this.teacherEnName,
      teacherUnionId: data.teacherUnionId.present
          ? data.teacherUnionId.value
          : this.teacherUnionId,
      robotCode: data.robotCode.present ? data.robotCode.value : this.robotCode,
      openConversationId: data.openConversationId.present
          ? data.openConversationId.value
          : this.openConversationId,
      chatId: data.chatId.present ? data.chatId.value : this.chatId,
      link: data.link.present ? data.link.value : this.link,
      assistant: data.assistant.present ? data.assistant.value : this.assistant,
      createAt: data.createAt.present ? data.createAt.value : this.createAt,
      updateAt: data.updateAt.present ? data.updateAt.value : this.updateAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Class(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('teacherId: $teacherId, ')
          ..write('teacherName: $teacherName, ')
          ..write('teacherEnName: $teacherEnName, ')
          ..write('teacherUnionId: $teacherUnionId, ')
          ..write('robotCode: $robotCode, ')
          ..write('openConversationId: $openConversationId, ')
          ..write('chatId: $chatId, ')
          ..write('link: $link, ')
          ..write('assistant: $assistant, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      icon,
      teacherId,
      teacherName,
      teacherEnName,
      teacherUnionId,
      robotCode,
      openConversationId,
      chatId,
      link,
      assistant,
      createAt,
      updateAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Class &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon &&
          other.teacherId == this.teacherId &&
          other.teacherName == this.teacherName &&
          other.teacherEnName == this.teacherEnName &&
          other.teacherUnionId == this.teacherUnionId &&
          other.robotCode == this.robotCode &&
          other.openConversationId == this.openConversationId &&
          other.chatId == this.chatId &&
          other.link == this.link &&
          other.assistant == this.assistant &&
          other.createAt == this.createAt &&
          other.updateAt == this.updateAt);
}

class ClassesCompanion extends UpdateCompanion<Class> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> icon;
  final Value<String?> teacherId;
  final Value<String?> teacherName;
  final Value<String?> teacherEnName;
  final Value<String?> teacherUnionId;
  final Value<String?> robotCode;
  final Value<String?> openConversationId;
  final Value<String?> chatId;
  final Value<String?> link;
  final Value<String?> assistant;
  final Value<String?> createAt;
  final Value<String?> updateAt;
  final Value<int> rowid;
  const ClassesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.teacherName = const Value.absent(),
    this.teacherEnName = const Value.absent(),
    this.teacherUnionId = const Value.absent(),
    this.robotCode = const Value.absent(),
    this.openConversationId = const Value.absent(),
    this.chatId = const Value.absent(),
    this.link = const Value.absent(),
    this.assistant = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClassesCompanion.insert({
    required String id,
    required String name,
    this.icon = const Value.absent(),
    this.teacherId = const Value.absent(),
    this.teacherName = const Value.absent(),
    this.teacherEnName = const Value.absent(),
    this.teacherUnionId = const Value.absent(),
    this.robotCode = const Value.absent(),
    this.openConversationId = const Value.absent(),
    this.chatId = const Value.absent(),
    this.link = const Value.absent(),
    this.assistant = const Value.absent(),
    this.createAt = const Value.absent(),
    this.updateAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name);
  static Insertable<Class> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? icon,
    Expression<String>? teacherId,
    Expression<String>? teacherName,
    Expression<String>? teacherEnName,
    Expression<String>? teacherUnionId,
    Expression<String>? robotCode,
    Expression<String>? openConversationId,
    Expression<String>? chatId,
    Expression<String>? link,
    Expression<String>? assistant,
    Expression<String>? createAt,
    Expression<String>? updateAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
      if (teacherId != null) 'teacher_id': teacherId,
      if (teacherName != null) 'teacher_name': teacherName,
      if (teacherEnName != null) 'teacher_en_name': teacherEnName,
      if (teacherUnionId != null) 'teacher_union_id': teacherUnionId,
      if (robotCode != null) 'robot_code': robotCode,
      if (openConversationId != null)
        'open_conversation_id': openConversationId,
      if (chatId != null) 'chat_id': chatId,
      if (link != null) 'link': link,
      if (assistant != null) 'assistant': assistant,
      if (createAt != null) 'create_at': createAt,
      if (updateAt != null) 'update_at': updateAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClassesCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<String?>? icon,
      Value<String?>? teacherId,
      Value<String?>? teacherName,
      Value<String?>? teacherEnName,
      Value<String?>? teacherUnionId,
      Value<String?>? robotCode,
      Value<String?>? openConversationId,
      Value<String?>? chatId,
      Value<String?>? link,
      Value<String?>? assistant,
      Value<String?>? createAt,
      Value<String?>? updateAt,
      Value<int>? rowid}) {
    return ClassesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
      teacherId: teacherId ?? this.teacherId,
      teacherName: teacherName ?? this.teacherName,
      teacherEnName: teacherEnName ?? this.teacherEnName,
      teacherUnionId: teacherUnionId ?? this.teacherUnionId,
      robotCode: robotCode ?? this.robotCode,
      openConversationId: openConversationId ?? this.openConversationId,
      chatId: chatId ?? this.chatId,
      link: link ?? this.link,
      assistant: assistant ?? this.assistant,
      createAt: createAt ?? this.createAt,
      updateAt: updateAt ?? this.updateAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (teacherId.present) {
      map['teacher_id'] = Variable<String>(teacherId.value);
    }
    if (teacherName.present) {
      map['teacher_name'] = Variable<String>(teacherName.value);
    }
    if (teacherEnName.present) {
      map['teacher_en_name'] = Variable<String>(teacherEnName.value);
    }
    if (teacherUnionId.present) {
      map['teacher_union_id'] = Variable<String>(teacherUnionId.value);
    }
    if (robotCode.present) {
      map['robot_code'] = Variable<String>(robotCode.value);
    }
    if (openConversationId.present) {
      map['open_conversation_id'] = Variable<String>(openConversationId.value);
    }
    if (chatId.present) {
      map['chat_id'] = Variable<String>(chatId.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (assistant.present) {
      map['assistant'] = Variable<String>(assistant.value);
    }
    if (createAt.present) {
      map['create_at'] = Variable<String>(createAt.value);
    }
    if (updateAt.present) {
      map['update_at'] = Variable<String>(updateAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon, ')
          ..write('teacherId: $teacherId, ')
          ..write('teacherName: $teacherName, ')
          ..write('teacherEnName: $teacherEnName, ')
          ..write('teacherUnionId: $teacherUnionId, ')
          ..write('robotCode: $robotCode, ')
          ..write('openConversationId: $openConversationId, ')
          ..write('chatId: $chatId, ')
          ..write('link: $link, ')
          ..write('assistant: $assistant, ')
          ..write('createAt: $createAt, ')
          ..write('updateAt: $updateAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TeachersTable teachers = $TeachersTable(this);
  late final $ClassesTable classes = $ClassesTable(this);
  late final TeacherDao teacherDao = TeacherDao(this as AppDatabase);
  late final ClassDao classDao = ClassDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [teachers, classes];
}

typedef $$TeachersTableCreateCompanionBuilder = TeachersCompanion Function({
  required String id,
  required String unionId,
  required String openId,
  Value<String?> type,
  Value<String?> username,
  Value<String?> stateCode,
  required String mobile,
  Value<String?> email,
  Value<String?> enName,
  Value<String?> name,
  Value<String?> avatar,
  Value<String?> gender,
  Value<String?> status,
  Value<String?> admin,
  Value<String?> lastLoginTime,
  Value<String?> lastLoginIp,
  Value<String?> birthday,
  Value<String?> homepage,
  Value<String?> token,
  Value<String?> loginType,
  Value<int> rowid,
});
typedef $$TeachersTableUpdateCompanionBuilder = TeachersCompanion Function({
  Value<String> id,
  Value<String> unionId,
  Value<String> openId,
  Value<String?> type,
  Value<String?> username,
  Value<String?> stateCode,
  Value<String> mobile,
  Value<String?> email,
  Value<String?> enName,
  Value<String?> name,
  Value<String?> avatar,
  Value<String?> gender,
  Value<String?> status,
  Value<String?> admin,
  Value<String?> lastLoginTime,
  Value<String?> lastLoginIp,
  Value<String?> birthday,
  Value<String?> homepage,
  Value<String?> token,
  Value<String?> loginType,
  Value<int> rowid,
});

class $$TeachersTableFilterComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unionId => $composableBuilder(
      column: $table.unionId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get openId => $composableBuilder(
      column: $table.openId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get stateCode => $composableBuilder(
      column: $table.stateCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mobile => $composableBuilder(
      column: $table.mobile, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get enName => $composableBuilder(
      column: $table.enName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get admin => $composableBuilder(
      column: $table.admin, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastLoginTime => $composableBuilder(
      column: $table.lastLoginTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastLoginIp => $composableBuilder(
      column: $table.lastLoginIp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get homepage => $composableBuilder(
      column: $table.homepage, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get token => $composableBuilder(
      column: $table.token, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get loginType => $composableBuilder(
      column: $table.loginType, builder: (column) => ColumnFilters(column));
}

class $$TeachersTableOrderingComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unionId => $composableBuilder(
      column: $table.unionId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get openId => $composableBuilder(
      column: $table.openId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get username => $composableBuilder(
      column: $table.username, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get stateCode => $composableBuilder(
      column: $table.stateCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mobile => $composableBuilder(
      column: $table.mobile, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get enName => $composableBuilder(
      column: $table.enName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get avatar => $composableBuilder(
      column: $table.avatar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get admin => $composableBuilder(
      column: $table.admin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastLoginTime => $composableBuilder(
      column: $table.lastLoginTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastLoginIp => $composableBuilder(
      column: $table.lastLoginIp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get birthday => $composableBuilder(
      column: $table.birthday, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get homepage => $composableBuilder(
      column: $table.homepage, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get token => $composableBuilder(
      column: $table.token, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get loginType => $composableBuilder(
      column: $table.loginType, builder: (column) => ColumnOrderings(column));
}

class $$TeachersTableAnnotationComposer
    extends Composer<_$AppDatabase, $TeachersTable> {
  $$TeachersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get unionId =>
      $composableBuilder(column: $table.unionId, builder: (column) => column);

  GeneratedColumn<String> get openId =>
      $composableBuilder(column: $table.openId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<String> get stateCode =>
      $composableBuilder(column: $table.stateCode, builder: (column) => column);

  GeneratedColumn<String> get mobile =>
      $composableBuilder(column: $table.mobile, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get enName =>
      $composableBuilder(column: $table.enName, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get admin =>
      $composableBuilder(column: $table.admin, builder: (column) => column);

  GeneratedColumn<String> get lastLoginTime => $composableBuilder(
      column: $table.lastLoginTime, builder: (column) => column);

  GeneratedColumn<String> get lastLoginIp => $composableBuilder(
      column: $table.lastLoginIp, builder: (column) => column);

  GeneratedColumn<String> get birthday =>
      $composableBuilder(column: $table.birthday, builder: (column) => column);

  GeneratedColumn<String> get homepage =>
      $composableBuilder(column: $table.homepage, builder: (column) => column);

  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

  GeneratedColumn<String> get loginType =>
      $composableBuilder(column: $table.loginType, builder: (column) => column);
}

class $$TeachersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TeachersTable,
    Teacher,
    $$TeachersTableFilterComposer,
    $$TeachersTableOrderingComposer,
    $$TeachersTableAnnotationComposer,
    $$TeachersTableCreateCompanionBuilder,
    $$TeachersTableUpdateCompanionBuilder,
    (Teacher, BaseReferences<_$AppDatabase, $TeachersTable, Teacher>),
    Teacher,
    PrefetchHooks Function()> {
  $$TeachersTableTableManager(_$AppDatabase db, $TeachersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TeachersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TeachersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TeachersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> unionId = const Value.absent(),
            Value<String> openId = const Value.absent(),
            Value<String?> type = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> stateCode = const Value.absent(),
            Value<String> mobile = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> enName = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> avatar = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> admin = const Value.absent(),
            Value<String?> lastLoginTime = const Value.absent(),
            Value<String?> lastLoginIp = const Value.absent(),
            Value<String?> birthday = const Value.absent(),
            Value<String?> homepage = const Value.absent(),
            Value<String?> token = const Value.absent(),
            Value<String?> loginType = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TeachersCompanion(
            id: id,
            unionId: unionId,
            openId: openId,
            type: type,
            username: username,
            stateCode: stateCode,
            mobile: mobile,
            email: email,
            enName: enName,
            name: name,
            avatar: avatar,
            gender: gender,
            status: status,
            admin: admin,
            lastLoginTime: lastLoginTime,
            lastLoginIp: lastLoginIp,
            birthday: birthday,
            homepage: homepage,
            token: token,
            loginType: loginType,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String unionId,
            required String openId,
            Value<String?> type = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String?> stateCode = const Value.absent(),
            required String mobile,
            Value<String?> email = const Value.absent(),
            Value<String?> enName = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> avatar = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<String?> status = const Value.absent(),
            Value<String?> admin = const Value.absent(),
            Value<String?> lastLoginTime = const Value.absent(),
            Value<String?> lastLoginIp = const Value.absent(),
            Value<String?> birthday = const Value.absent(),
            Value<String?> homepage = const Value.absent(),
            Value<String?> token = const Value.absent(),
            Value<String?> loginType = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TeachersCompanion.insert(
            id: id,
            unionId: unionId,
            openId: openId,
            type: type,
            username: username,
            stateCode: stateCode,
            mobile: mobile,
            email: email,
            enName: enName,
            name: name,
            avatar: avatar,
            gender: gender,
            status: status,
            admin: admin,
            lastLoginTime: lastLoginTime,
            lastLoginIp: lastLoginIp,
            birthday: birthday,
            homepage: homepage,
            token: token,
            loginType: loginType,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TeachersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TeachersTable,
    Teacher,
    $$TeachersTableFilterComposer,
    $$TeachersTableOrderingComposer,
    $$TeachersTableAnnotationComposer,
    $$TeachersTableCreateCompanionBuilder,
    $$TeachersTableUpdateCompanionBuilder,
    (Teacher, BaseReferences<_$AppDatabase, $TeachersTable, Teacher>),
    Teacher,
    PrefetchHooks Function()>;
typedef $$ClassesTableCreateCompanionBuilder = ClassesCompanion Function({
  required String id,
  required String name,
  Value<String?> icon,
  Value<String?> teacherId,
  Value<String?> teacherName,
  Value<String?> teacherEnName,
  Value<String?> teacherUnionId,
  Value<String?> robotCode,
  Value<String?> openConversationId,
  Value<String?> chatId,
  Value<String?> link,
  Value<String?> assistant,
  Value<String?> createAt,
  Value<String?> updateAt,
  Value<int> rowid,
});
typedef $$ClassesTableUpdateCompanionBuilder = ClassesCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<String?> icon,
  Value<String?> teacherId,
  Value<String?> teacherName,
  Value<String?> teacherEnName,
  Value<String?> teacherUnionId,
  Value<String?> robotCode,
  Value<String?> openConversationId,
  Value<String?> chatId,
  Value<String?> link,
  Value<String?> assistant,
  Value<String?> createAt,
  Value<String?> updateAt,
  Value<int> rowid,
});

class $$ClassesTableFilterComposer
    extends Composer<_$AppDatabase, $ClassesTable> {
  $$ClassesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teacherId => $composableBuilder(
      column: $table.teacherId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teacherName => $composableBuilder(
      column: $table.teacherName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teacherEnName => $composableBuilder(
      column: $table.teacherEnName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get teacherUnionId => $composableBuilder(
      column: $table.teacherUnionId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get robotCode => $composableBuilder(
      column: $table.robotCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get openConversationId => $composableBuilder(
      column: $table.openConversationId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get chatId => $composableBuilder(
      column: $table.chatId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get assistant => $composableBuilder(
      column: $table.assistant, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createAt => $composableBuilder(
      column: $table.createAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get updateAt => $composableBuilder(
      column: $table.updateAt, builder: (column) => ColumnFilters(column));
}

class $$ClassesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassesTable> {
  $$ClassesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get icon => $composableBuilder(
      column: $table.icon, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teacherId => $composableBuilder(
      column: $table.teacherId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teacherName => $composableBuilder(
      column: $table.teacherName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teacherEnName => $composableBuilder(
      column: $table.teacherEnName,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get teacherUnionId => $composableBuilder(
      column: $table.teacherUnionId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get robotCode => $composableBuilder(
      column: $table.robotCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get openConversationId => $composableBuilder(
      column: $table.openConversationId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get chatId => $composableBuilder(
      column: $table.chatId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get link => $composableBuilder(
      column: $table.link, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get assistant => $composableBuilder(
      column: $table.assistant, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createAt => $composableBuilder(
      column: $table.createAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get updateAt => $composableBuilder(
      column: $table.updateAt, builder: (column) => ColumnOrderings(column));
}

class $$ClassesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassesTable> {
  $$ClassesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<String> get teacherId =>
      $composableBuilder(column: $table.teacherId, builder: (column) => column);

  GeneratedColumn<String> get teacherName => $composableBuilder(
      column: $table.teacherName, builder: (column) => column);

  GeneratedColumn<String> get teacherEnName => $composableBuilder(
      column: $table.teacherEnName, builder: (column) => column);

  GeneratedColumn<String> get teacherUnionId => $composableBuilder(
      column: $table.teacherUnionId, builder: (column) => column);

  GeneratedColumn<String> get robotCode =>
      $composableBuilder(column: $table.robotCode, builder: (column) => column);

  GeneratedColumn<String> get openConversationId => $composableBuilder(
      column: $table.openConversationId, builder: (column) => column);

  GeneratedColumn<String> get chatId =>
      $composableBuilder(column: $table.chatId, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<String> get assistant =>
      $composableBuilder(column: $table.assistant, builder: (column) => column);

  GeneratedColumn<String> get createAt =>
      $composableBuilder(column: $table.createAt, builder: (column) => column);

  GeneratedColumn<String> get updateAt =>
      $composableBuilder(column: $table.updateAt, builder: (column) => column);
}

class $$ClassesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClassesTable,
    Class,
    $$ClassesTableFilterComposer,
    $$ClassesTableOrderingComposer,
    $$ClassesTableAnnotationComposer,
    $$ClassesTableCreateCompanionBuilder,
    $$ClassesTableUpdateCompanionBuilder,
    (Class, BaseReferences<_$AppDatabase, $ClassesTable, Class>),
    Class,
    PrefetchHooks Function()> {
  $$ClassesTableTableManager(_$AppDatabase db, $ClassesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> icon = const Value.absent(),
            Value<String?> teacherId = const Value.absent(),
            Value<String?> teacherName = const Value.absent(),
            Value<String?> teacherEnName = const Value.absent(),
            Value<String?> teacherUnionId = const Value.absent(),
            Value<String?> robotCode = const Value.absent(),
            Value<String?> openConversationId = const Value.absent(),
            Value<String?> chatId = const Value.absent(),
            Value<String?> link = const Value.absent(),
            Value<String?> assistant = const Value.absent(),
            Value<String?> createAt = const Value.absent(),
            Value<String?> updateAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClassesCompanion(
            id: id,
            name: name,
            icon: icon,
            teacherId: teacherId,
            teacherName: teacherName,
            teacherEnName: teacherEnName,
            teacherUnionId: teacherUnionId,
            robotCode: robotCode,
            openConversationId: openConversationId,
            chatId: chatId,
            link: link,
            assistant: assistant,
            createAt: createAt,
            updateAt: updateAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            Value<String?> icon = const Value.absent(),
            Value<String?> teacherId = const Value.absent(),
            Value<String?> teacherName = const Value.absent(),
            Value<String?> teacherEnName = const Value.absent(),
            Value<String?> teacherUnionId = const Value.absent(),
            Value<String?> robotCode = const Value.absent(),
            Value<String?> openConversationId = const Value.absent(),
            Value<String?> chatId = const Value.absent(),
            Value<String?> link = const Value.absent(),
            Value<String?> assistant = const Value.absent(),
            Value<String?> createAt = const Value.absent(),
            Value<String?> updateAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ClassesCompanion.insert(
            id: id,
            name: name,
            icon: icon,
            teacherId: teacherId,
            teacherName: teacherName,
            teacherEnName: teacherEnName,
            teacherUnionId: teacherUnionId,
            robotCode: robotCode,
            openConversationId: openConversationId,
            chatId: chatId,
            link: link,
            assistant: assistant,
            createAt: createAt,
            updateAt: updateAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClassesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClassesTable,
    Class,
    $$ClassesTableFilterComposer,
    $$ClassesTableOrderingComposer,
    $$ClassesTableAnnotationComposer,
    $$ClassesTableCreateCompanionBuilder,
    $$ClassesTableUpdateCompanionBuilder,
    (Class, BaseReferences<_$AppDatabase, $ClassesTable, Class>),
    Class,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TeachersTableTableManager get teachers =>
      $$TeachersTableTableManager(_db, _db.teachers);
  $$ClassesTableTableManager get classes =>
      $$ClassesTableTableManager(_db, _db.classes);
}
