class LoginInfo {
  String? id;
  String? unionId;
  String? openId;
  String? type;
  String? username;
  String? stateCode;
  String? mobile;
  String? email;
  String? enName;
  String? name;
  String? avatar;
  String? gender;
  String? status;
  String? admin;
  String? lastLoginTime;
  String? lastLoginIp;
  String? birthday;
  String? homepage;
  String? token;
  String? loginType;
  // 当前身份是学生时，以下字段有效
  String? teacherId;
  String? classId;
  String? courseId;
  String? totalTimes;
  String? usedTimes;

  LoginInfo({
    this.id,
    this.unionId,
    this.openId,
    this.type,
    this.username,
    this.stateCode,
    this.mobile,
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
    this.loginType,
    this.teacherId,
    this.classId,
    this.courseId,
    this.totalTimes,
    this.usedTimes,
  });

  LoginInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unionId = json['unionId'];
    openId = json['openId'];
    type = json['type'];
    username = json['username'];
    stateCode = json['stateCode'];
    mobile = json['mobile'];
    email = json['email'];
    enName = json['enName'];
    name = json['name'];
    avatar = json['avatar'];
    homepage = json['homepage'];
    lastLoginTime = json['lastLoginTime'];
    lastLoginIp = json['lastLoginIp'];
    birthday = json['birthday'];
    gender = json['gender'];
    status = json['status'];
    admin = json['admin'];
    token = json['token'];
    loginType = json['loginType'];
    teacherId = json['teacherId'];
    classId = json['classId'];
    courseId = json['courseId'];
    totalTimes = json['totalTimes'];
    usedTimes = json['usedTimes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unionId'] = unionId;
    data['openId'] = openId;
    data['type'] = type;
    data['username'] = username;
    data['stateCode'] = stateCode;
    data['mobile'] = mobile;
    data['email'] = email;
    data['enName'] = enName;
    data['name'] = name;
    data['avatar'] = avatar;
    data['gender'] = gender;
    data['status'] = status;
    data['admin'] = admin;
    data['homepage'] = homepage;
    data['lastLoginTime'] = lastLoginTime;
    data['lastLoginIp'] = lastLoginIp;
    data['birthday'] = birthday;
    data['token'] = token;
    data['loginType'] = loginType;
    data['teacherId'] = teacherId;
    data['classId'] = classId;
    data['courseId'] = courseId;
    data['totalTimes'] = totalTimes;
    data['usedTimes'] = usedTimes;
    return data;
  }
}
