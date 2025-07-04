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
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
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
      'state_code', aliasedName, false,
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
      'gender', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('男'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('在职'));
  static const VerificationMeta _adminMeta = const VerificationMeta('admin');
  @override
  late final GeneratedColumn<String> admin = GeneratedColumn<String>(
      'admin', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('0'));
  static const VerificationMeta _lastLoginTimeMeta =
      const VerificationMeta('lastLoginTime');
  @override
  late final GeneratedColumn<BigInt> lastLoginTime = GeneratedColumn<BigInt>(
      'last_login_time', aliasedName, false,
      type: DriftSqlType.bigInt,
      requiredDuringInsert: false,
      defaultValue:
          Constant(BigInt.from(DateTime.now().millisecondsSinceEpoch)));
  static const VerificationMeta _lastLoginIpMeta =
      const VerificationMeta('lastLoginIp');
  @override
  late final GeneratedColumn<String> lastLoginIp = GeneratedColumn<String>(
      'last_login_ip', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _birthdayMeta =
      const VerificationMeta('birthday');
  @override
  late final GeneratedColumn<BigInt> birthday = GeneratedColumn<BigInt>(
      'birthday', aliasedName, false,
      type: DriftSqlType.bigInt,
      requiredDuringInsert: false,
      defaultValue: Constant(BigInt.from(1548720488000)));
  static const VerificationMeta _homepageMeta =
      const VerificationMeta('homepage');
  @override
  late final GeneratedColumn<String> homepage = GeneratedColumn<String>(
      'homepage', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
      'token', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _loginTypeMeta =
      const VerificationMeta('loginType');
  @override
  late final GeneratedColumn<String> loginType = GeneratedColumn<String>(
      'login_type', aliasedName, false,
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
    } else if (isInserting) {
      context.missing(_typeMeta);
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
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('login_type')) {
      context.handle(_loginTypeMeta,
          loginType.isAcceptableOrUnknown(data['login_type']!, _loginTypeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
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
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      username: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}username']),
      stateCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}state_code'])!,
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
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      admin: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}admin'])!,
      lastLoginTime: attachedDatabase.typeMapping.read(
          DriftSqlType.bigInt, data['${effectivePrefix}last_login_time'])!,
      lastLoginIp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_login_ip']),
      birthday: attachedDatabase.typeMapping
          .read(DriftSqlType.bigInt, data['${effectivePrefix}birthday'])!,
      homepage: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}homepage']),
      token: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}token'])!,
      loginType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}login_type'])!,
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
  final String type;
  final String? username;
  final String stateCode;
  final String mobile;
  final String? email;
  final String? enName;
  final String? name;
  final String? avatar;
  final String gender;
  final String status;
  final String admin;
  final BigInt lastLoginTime;
  final String? lastLoginIp;
  final BigInt birthday;
  final String? homepage;
  final String token;
  final String loginType;
  const Teacher(
      {required this.id,
      required this.unionId,
      required this.openId,
      required this.type,
      this.username,
      required this.stateCode,
      required this.mobile,
      this.email,
      this.enName,
      this.name,
      this.avatar,
      required this.gender,
      required this.status,
      required this.admin,
      required this.lastLoginTime,
      this.lastLoginIp,
      required this.birthday,
      this.homepage,
      required this.token,
      required this.loginType});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['union_id'] = Variable<String>(unionId);
    map['open_id'] = Variable<String>(openId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || username != null) {
      map['username'] = Variable<String>(username);
    }
    map['state_code'] = Variable<String>(stateCode);
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
    map['gender'] = Variable<String>(gender);
    map['status'] = Variable<String>(status);
    map['admin'] = Variable<String>(admin);
    map['last_login_time'] = Variable<BigInt>(lastLoginTime);
    if (!nullToAbsent || lastLoginIp != null) {
      map['last_login_ip'] = Variable<String>(lastLoginIp);
    }
    map['birthday'] = Variable<BigInt>(birthday);
    if (!nullToAbsent || homepage != null) {
      map['homepage'] = Variable<String>(homepage);
    }
    map['token'] = Variable<String>(token);
    map['login_type'] = Variable<String>(loginType);
    return map;
  }

  TeachersCompanion toCompanion(bool nullToAbsent) {
    return TeachersCompanion(
      id: Value(id),
      unionId: Value(unionId),
      openId: Value(openId),
      type: Value(type),
      username: username == null && nullToAbsent
          ? const Value.absent()
          : Value(username),
      stateCode: Value(stateCode),
      mobile: Value(mobile),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      enName:
          enName == null && nullToAbsent ? const Value.absent() : Value(enName),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      gender: Value(gender),
      status: Value(status),
      admin: Value(admin),
      lastLoginTime: Value(lastLoginTime),
      lastLoginIp: lastLoginIp == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginIp),
      birthday: Value(birthday),
      homepage: homepage == null && nullToAbsent
          ? const Value.absent()
          : Value(homepage),
      token: Value(token),
      loginType: Value(loginType),
    );
  }

  factory Teacher.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Teacher(
      id: serializer.fromJson<String>(json['id']),
      unionId: serializer.fromJson<String>(json['unionId']),
      openId: serializer.fromJson<String>(json['openId']),
      type: serializer.fromJson<String>(json['type']),
      username: serializer.fromJson<String?>(json['username']),
      stateCode: serializer.fromJson<String>(json['stateCode']),
      mobile: serializer.fromJson<String>(json['mobile']),
      email: serializer.fromJson<String?>(json['email']),
      enName: serializer.fromJson<String?>(json['enName']),
      name: serializer.fromJson<String?>(json['name']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      gender: serializer.fromJson<String>(json['gender']),
      status: serializer.fromJson<String>(json['status']),
      admin: serializer.fromJson<String>(json['admin']),
      lastLoginTime: serializer.fromJson<BigInt>(json['lastLoginTime']),
      lastLoginIp: serializer.fromJson<String?>(json['lastLoginIp']),
      birthday: serializer.fromJson<BigInt>(json['birthday']),
      homepage: serializer.fromJson<String?>(json['homepage']),
      token: serializer.fromJson<String>(json['token']),
      loginType: serializer.fromJson<String>(json['loginType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'unionId': serializer.toJson<String>(unionId),
      'openId': serializer.toJson<String>(openId),
      'type': serializer.toJson<String>(type),
      'username': serializer.toJson<String?>(username),
      'stateCode': serializer.toJson<String>(stateCode),
      'mobile': serializer.toJson<String>(mobile),
      'email': serializer.toJson<String?>(email),
      'enName': serializer.toJson<String?>(enName),
      'name': serializer.toJson<String?>(name),
      'avatar': serializer.toJson<String?>(avatar),
      'gender': serializer.toJson<String>(gender),
      'status': serializer.toJson<String>(status),
      'admin': serializer.toJson<String>(admin),
      'lastLoginTime': serializer.toJson<BigInt>(lastLoginTime),
      'lastLoginIp': serializer.toJson<String?>(lastLoginIp),
      'birthday': serializer.toJson<BigInt>(birthday),
      'homepage': serializer.toJson<String?>(homepage),
      'token': serializer.toJson<String>(token),
      'loginType': serializer.toJson<String>(loginType),
    };
  }

  Teacher copyWith(
          {String? id,
          String? unionId,
          String? openId,
          String? type,
          Value<String?> username = const Value.absent(),
          String? stateCode,
          String? mobile,
          Value<String?> email = const Value.absent(),
          Value<String?> enName = const Value.absent(),
          Value<String?> name = const Value.absent(),
          Value<String?> avatar = const Value.absent(),
          String? gender,
          String? status,
          String? admin,
          BigInt? lastLoginTime,
          Value<String?> lastLoginIp = const Value.absent(),
          BigInt? birthday,
          Value<String?> homepage = const Value.absent(),
          String? token,
          String? loginType}) =>
      Teacher(
        id: id ?? this.id,
        unionId: unionId ?? this.unionId,
        openId: openId ?? this.openId,
        type: type ?? this.type,
        username: username.present ? username.value : this.username,
        stateCode: stateCode ?? this.stateCode,
        mobile: mobile ?? this.mobile,
        email: email.present ? email.value : this.email,
        enName: enName.present ? enName.value : this.enName,
        name: name.present ? name.value : this.name,
        avatar: avatar.present ? avatar.value : this.avatar,
        gender: gender ?? this.gender,
        status: status ?? this.status,
        admin: admin ?? this.admin,
        lastLoginTime: lastLoginTime ?? this.lastLoginTime,
        lastLoginIp: lastLoginIp.present ? lastLoginIp.value : this.lastLoginIp,
        birthday: birthday ?? this.birthday,
        homepage: homepage.present ? homepage.value : this.homepage,
        token: token ?? this.token,
        loginType: loginType ?? this.loginType,
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
  final Value<String> type;
  final Value<String?> username;
  final Value<String> stateCode;
  final Value<String> mobile;
  final Value<String?> email;
  final Value<String?> enName;
  final Value<String?> name;
  final Value<String?> avatar;
  final Value<String> gender;
  final Value<String> status;
  final Value<String> admin;
  final Value<BigInt> lastLoginTime;
  final Value<String?> lastLoginIp;
  final Value<BigInt> birthday;
  final Value<String?> homepage;
  final Value<String> token;
  final Value<String> loginType;
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
    required String type,
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
    required String token,
    this.loginType = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        unionId = Value(unionId),
        openId = Value(openId),
        type = Value(type),
        mobile = Value(mobile),
        token = Value(token);
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
    Expression<BigInt>? lastLoginTime,
    Expression<String>? lastLoginIp,
    Expression<BigInt>? birthday,
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
      Value<String>? type,
      Value<String?>? username,
      Value<String>? stateCode,
      Value<String>? mobile,
      Value<String?>? email,
      Value<String?>? enName,
      Value<String?>? name,
      Value<String?>? avatar,
      Value<String>? gender,
      Value<String>? status,
      Value<String>? admin,
      Value<BigInt>? lastLoginTime,
      Value<String?>? lastLoginIp,
      Value<BigInt>? birthday,
      Value<String?>? homepage,
      Value<String>? token,
      Value<String>? loginType,
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
      map['last_login_time'] = Variable<BigInt>(lastLoginTime.value);
    }
    if (lastLoginIp.present) {
      map['last_login_ip'] = Variable<String>(lastLoginIp.value);
    }
    if (birthday.present) {
      map['birthday'] = Variable<BigInt>(birthday.value);
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TeachersTable teachers = $TeachersTable(this);
  late final TeacherDao teacherDao = TeacherDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [teachers];
}

typedef $$TeachersTableCreateCompanionBuilder = TeachersCompanion Function({
  required String id,
  required String unionId,
  required String openId,
  required String type,
  Value<String?> username,
  Value<String> stateCode,
  required String mobile,
  Value<String?> email,
  Value<String?> enName,
  Value<String?> name,
  Value<String?> avatar,
  Value<String> gender,
  Value<String> status,
  Value<String> admin,
  Value<BigInt> lastLoginTime,
  Value<String?> lastLoginIp,
  Value<BigInt> birthday,
  Value<String?> homepage,
  required String token,
  Value<String> loginType,
  Value<int> rowid,
});
typedef $$TeachersTableUpdateCompanionBuilder = TeachersCompanion Function({
  Value<String> id,
  Value<String> unionId,
  Value<String> openId,
  Value<String> type,
  Value<String?> username,
  Value<String> stateCode,
  Value<String> mobile,
  Value<String?> email,
  Value<String?> enName,
  Value<String?> name,
  Value<String?> avatar,
  Value<String> gender,
  Value<String> status,
  Value<String> admin,
  Value<BigInt> lastLoginTime,
  Value<String?> lastLoginIp,
  Value<BigInt> birthday,
  Value<String?> homepage,
  Value<String> token,
  Value<String> loginType,
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

  ColumnFilters<BigInt> get lastLoginTime => $composableBuilder(
      column: $table.lastLoginTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastLoginIp => $composableBuilder(
      column: $table.lastLoginIp, builder: (column) => ColumnFilters(column));

  ColumnFilters<BigInt> get birthday => $composableBuilder(
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

  ColumnOrderings<BigInt> get lastLoginTime => $composableBuilder(
      column: $table.lastLoginTime,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastLoginIp => $composableBuilder(
      column: $table.lastLoginIp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<BigInt> get birthday => $composableBuilder(
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

  GeneratedColumn<BigInt> get lastLoginTime => $composableBuilder(
      column: $table.lastLoginTime, builder: (column) => column);

  GeneratedColumn<String> get lastLoginIp => $composableBuilder(
      column: $table.lastLoginIp, builder: (column) => column);

  GeneratedColumn<BigInt> get birthday =>
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
            Value<String> type = const Value.absent(),
            Value<String?> username = const Value.absent(),
            Value<String> stateCode = const Value.absent(),
            Value<String> mobile = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> enName = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> avatar = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> admin = const Value.absent(),
            Value<BigInt> lastLoginTime = const Value.absent(),
            Value<String?> lastLoginIp = const Value.absent(),
            Value<BigInt> birthday = const Value.absent(),
            Value<String?> homepage = const Value.absent(),
            Value<String> token = const Value.absent(),
            Value<String> loginType = const Value.absent(),
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
            required String type,
            Value<String?> username = const Value.absent(),
            Value<String> stateCode = const Value.absent(),
            required String mobile,
            Value<String?> email = const Value.absent(),
            Value<String?> enName = const Value.absent(),
            Value<String?> name = const Value.absent(),
            Value<String?> avatar = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> admin = const Value.absent(),
            Value<BigInt> lastLoginTime = const Value.absent(),
            Value<String?> lastLoginIp = const Value.absent(),
            Value<BigInt> birthday = const Value.absent(),
            Value<String?> homepage = const Value.absent(),
            required String token,
            Value<String> loginType = const Value.absent(),
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TeachersTableTableManager get teachers =>
      $$TeachersTableTableManager(_db, _db.teachers);
}
