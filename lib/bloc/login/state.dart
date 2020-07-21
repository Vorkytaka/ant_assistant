abstract class LoginState {
  const LoginState();
}

class LoginIsEmpty extends LoginState {
  const LoginIsEmpty();
}

class LoginIsLoading extends LoginState {
  const LoginIsLoading();
}

class LoginCredentialsValid extends LoginState {
  final String username;
  final String password;

  const LoginCredentialsValid({this.username, this.password});
}

class LoginError extends LoginState {
  const LoginError();
}

class LoginSuccess extends LoginState {
  final int id;

  const LoginSuccess({this.id});
}
