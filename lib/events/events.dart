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
