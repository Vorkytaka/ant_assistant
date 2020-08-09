import 'package:antassistant/entity/credentials.dart';
import 'package:meta/meta.dart';

abstract class AuthBlocState {
  const AuthBlocState();
}

class Unauthenticated extends AuthBlocState {
  const Unauthenticated();
}

class Authenticated extends AuthBlocState {
  final List<Credentials> credentials;

  const Authenticated({@required this.credentials})
      : assert(credentials != null),
        assert(credentials.length > 0);
}
