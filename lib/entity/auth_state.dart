import 'package:antassistant/entity/credentials.dart';

class AuthState {
  final bool isSuccess;
  final Credentials credentials;

  AuthState(this.isSuccess, this.credentials);

  @override
  String toString() {
    return "Success: $isSuccess; $credentials";
  }
}
