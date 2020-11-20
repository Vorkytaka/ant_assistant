import 'package:antassistant/data/source/naming/user_scheme.dart';
import 'package:meta/meta.dart';

@immutable
class Credentials {
  final String username;
  final String password;

  Credentials({
    @required this.username,
    @required this.password,
  })  : assert(username != null),
        assert(password != null);

  @override
  String toString() => "Credentials($username, ${"•" * password.length})";
}

extension DBCredentials on Credentials {
  Map<String, dynamic> toMap() => {
        UsersScheme.COLUMN_NAME_LOGIN: username,
        UsersScheme.COLUMN_NAME_PASSWORD: password,
      };
}
