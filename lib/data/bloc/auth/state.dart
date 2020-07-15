import 'package:antassistant/entity/credentials.dart';

abstract class AuthBlocState {
  const AuthBlocState();
}

class Unauthenticated extends AuthBlocState {
  const Unauthenticated();
}

class Authenticated extends AuthBlocState {
  final List<Credentials> credentials;

  const Authenticated(this.credentials);
}
