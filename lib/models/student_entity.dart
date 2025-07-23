import 'package:wingapp/database/database.dart';

class StudentEntity {
  String id;
  String? unionId;
  String? openId;
  String? username;
  String? stateCode;
  String? mobile;
  String? email;
  String? enName;
  String? name;
  String? avatar;
  String? gender;
  String? status;
  String? classId;
  String? teacherId;
  String? courseId;
  String? totalSessions;
  String? completedSessions;
  String? lastLoginTime;
  String? lastLoginIp;
  String? birthday;
  String? homepage;
  String? token;
  String? loginType;
  Class? classInfo;

  StudentEntity({
    required this.id,
    this.unionId,
    this.openId,
    this.username,
    this.stateCode,
    this.mobile,
    this.email,
    this.enName,
    this.name,
    this.avatar,
    this.gender,
    this.status,
    this.classId,
    this.teacherId,
    this.courseId,
    this.totalSessions,
    this.completedSessions,
    this.lastLoginTime,
    this.lastLoginIp,
    this.birthday,
    this.homepage,
    this.token,
    this.loginType,
    this.classInfo,
  });

  factory StudentEntity.fromJson(Map<String, dynamic> json) {
    return StudentEntity(
      id: json['id'] ?? '',
      unionId: json['unionId'] ?? '',
      openId: json['openId'] ?? '',
      username: json['username'] ?? '',
      stateCode: json['stateCode'] ?? '',
      mobile: json['mobile'] ?? '',
      email: json['email'] ?? '',
      enName: json['enName'] ?? '',
      name: json['name'] ?? '',
      avatar: json['avatar'] ?? '',
      gender: json['gender'] ?? '',
      status: json['status'] ?? '',
      classId: json['classId'] ?? '',
      teacherId: json['teacherId'] ?? '',
      courseId: json['courseId'] ?? '',
      totalSessions: json['totalSessions'] ?? '',
      completedSessions: json['completedSessions'] ?? '',
      lastLoginTime: json['lastLoginTime'] ?? '',
      lastLoginIp: json['lastLoginIp'] ?? '',
      birthday: json['birthday'] ?? '',
      homepage: json['homepage'] ?? '',
      token: json['token'] ?? '',
      loginType: json['loginType'] ?? '',
      classInfo: (json['classInfo'] != null && json['classInfo']['id'] != null)
          ? Class.fromJson(json['classInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unionId'] = unionId;
    data['openId'] = openId;
    data['username'] = username;
    data['stateCode'] = stateCode;
    data['mobile'] = mobile;
    data['email'] = email;
    data['enName'] = enName;
    data['name'] = name;
    data['avatar'] = avatar;
    data['gender'] = gender;
    data['status'] = status;
    data['classId'] = classId;
    data['teacherId'] = teacherId;
    data['courseId'] = courseId;
    data['totalSessions'] = totalSessions;
    data['completedSessions'] = completedSessions;
    data['lastLoginTime'] = lastLoginTime;
    data['lastLoginIp'] = lastLoginIp;
    data['birthday'] = birthday;
    data['homepage'] = homepage;
    data['token'] = token;
    data['loginType'] = loginType;
    data['classInfo'] = classInfo;
    return data;
  }
}
