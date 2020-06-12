import 'package:dio/dio.dart' as dio;

const String _BASE_URL = "http://cabinet.a-n-t.ru/cabinet.php";

const String _KEY_ACTION = "action";
const String _KEY_USERNAME = "user_name";
const String _KEY_PASSWORD = "user_pass";

const String _ACTION_INFO = "info";

Future<AuthState> auth(String login, String password) async {
  final dio.BaseOptions options = dio.BaseOptions(followRedirects: true);
  var params = {
    _KEY_ACTION: _ACTION_INFO,
    _KEY_USERNAME: login,
    _KEY_PASSWORD: password
  };
  var httpParams = dio.FormData.fromMap(params);

  try {
    await dio.Dio(options).post(_BASE_URL, data: httpParams);
    return AuthState(true, login, password);
  } catch (err) {
    return AuthState(false, login, password);
  }
}

class AuthState {
  final bool isSuccess;
  String login;
  String password;

  AuthState(this.isSuccess, this.login, this.password);
}
