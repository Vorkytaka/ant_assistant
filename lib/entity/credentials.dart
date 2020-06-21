import 'IDEntity.dart';

class Credentials extends Mapped {
  final String login;
  final String password;

  Credentials(this.login, this.password);

  @override
  String toString() => "($login, ••••••••))";

  @override
  Map<String, dynamic> toMap() => {
        "login": login,
        "password": password,
      };
}
