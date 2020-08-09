import 'package:meta/meta.dart';

@immutable
class Credentials {
  final String username;
  final String password;

  Credentials({@required this.username, @required this.password})
      : assert(username != null),
        assert(password != null);

  @override
  String toString() => "($username, ••••••••))";
}

extension DBCredentials on Credentials {
  Map<String, dynamic> toMap() => {
        "login": username,
        "password": password,
      };
}
