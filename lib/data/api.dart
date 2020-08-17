import 'package:antassistant/data/parser.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/id_entity.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:html/parser.dart';

class Api {
  static const String _BASE_URL = "http://cabinet.a-n-t.ru/cabinet.php";

  static const String _KEY_ACTION = "action";
  static const String _KEY_USERNAME = "user_name";
  static const String _KEY_PASSWORD = "user_pass";

  static const String _ACTION_INFO = "info";

  Future<bool> login(Credentials credentials) async {
    final BaseOptions options = BaseOptions(followRedirects: true);
    var params = {
      _KEY_ACTION: _ACTION_INFO,
      _KEY_USERNAME: credentials.username,
      _KEY_PASSWORD: credentials.password
    };
    var httpParams = FormData.fromMap(params);

    try {
      await Dio(options).post(_BASE_URL, data: httpParams);
      return true;
    } catch (err) {
      return false;
    }
  }

  Future<UserData> getUserData(IDEntity<Credentials> credentials) async {
    final BaseOptions options = BaseOptions(followRedirects: true);
    var params = {
      _KEY_ACTION: _ACTION_INFO,
      _KEY_USERNAME: credentials.entity.username,
      _KEY_PASSWORD: credentials.entity.password
    };
    var httpParams = FormData.fromMap(params);

    try {
      final response = await Dio(options).post(_BASE_URL, data: httpParams);
      final document = parse(response.data);
      return compute(parseUserData, ParsingData(credentials.id, document));
    } catch (err) {
      return null;
    }
  }
}
