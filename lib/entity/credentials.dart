class Credentials {
  final String login;
  final String password;

  Credentials(this.login, this.password);

  @override
  String toString() => "($login, ••••••••))";
}

extension DBCredentials on Credentials {
  Map<String, dynamic> toMap() => {
        "login": login,
        "password": password,
      };
}