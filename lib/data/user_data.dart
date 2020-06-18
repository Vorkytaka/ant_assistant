import 'dart:async';

import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/user_data.dart';

abstract class Repository {
  bool isThereAnyAccount();

  void saveUser(Credentials credentials);

  Stream<List<UserData>> getUsersDataStream();
}

class RepositoryImpl extends Repository {
  final List<Credentials> _users = List();
  final StreamController<List<UserData>> _controller = StreamController();

  @override
  bool isThereAnyAccount() {
    return _users.isNotEmpty;
  }

  @override
  void saveUser(Credentials credentials) {
    _users.add(credentials);
    // async get data
    final List<UserData> data =
        _users.map((e) => UserData(e.login, null, null, null)).toList();
    _controller.add(data);
  }

  @override
  Stream<List<UserData>> getUsersDataStream() {
    return _controller.stream;
  }
}
