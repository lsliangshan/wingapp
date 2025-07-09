import 'package:wingapp/models/login_info.model.dart';
import 'package:wingapp/types/types.dart';

class TabChangeEvent {
  TabName name;

  TabChangeEvent({
    required this.name,
  });
}

class LoginEvent {
  LoginInfo loginInfo;

  LoginEvent(this.loginInfo);
}

class LogoutEvent {
  LogoutEvent();
}

class NeedLoginEvent {
  NeedLoginEvent();
}

class NeedLoginCallbackEvent {
  final bool isSuccess;
  NeedLoginCallbackEvent({
    required this.isSuccess,
  });
}
