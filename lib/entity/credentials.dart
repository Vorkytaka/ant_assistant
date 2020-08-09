import 'package:meta/meta.dart';

class Credentials {
  final String login;
  final String password;

  Credentials({@required this.login, @required this.password});

  @override
  String toString() => "($login, ••••••••))";
}

extension DBCredentials on Credentials {
  Map<String, dynamic> toMap() => {
    "login": login,
    "password": password,
  };
}