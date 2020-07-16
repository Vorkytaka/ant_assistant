import 'package:antassistant/data/parser.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/id_entity.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:dio/dio.dart' as dio;
import 'package:html/parser.dart' as parser;

const String _BASE_URL = "http://cabinet.a-n-t.ru/cabinet.php";

const String _KEY_ACTION = "action";
const String _KEY_USERNAME = "user_name";
const String _KEY_PASSWORD = "user_pass";

const String _ACTION_INFO = "info";

Future<UserData> getUserData(IDEntity<Credentials> credentials) async {
  final dio.BaseOptions options = dio.BaseOptions(followRedirects: true);
  var params = {
    _KEY_ACTION: _ACTION_INFO,
    _KEY_USERNAME: credentials.entity.login,
    _KEY_PASSWORD: credentials.entity.password
  };
  var httpParams = dio.FormData.fromMap(params);

  try {
    final response = await dio.Dio(options).post(_BASE_URL, data: httpParams);
    final document = parser.parse(response.data);
    return parseUserData(credentials.id, document);
  } catch (err) {
    return null;
  }
}
