abstract class LoginEvent {
  const LoginEvent();
}

class LoginUsernameChanged extends LoginEvent {
  final String username;

  const LoginUsernameChanged({this.username});
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  const LoginPasswordChanged({this.password});
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({this.username, this.password});
}
