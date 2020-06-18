class AuthState {
  final bool isSuccess;
  String login;
  String password;

  AuthState(this.isSuccess, this.login, this.password);

  @override
  String toString() {
    return "$login, $password, $isSuccess";
  }
}
