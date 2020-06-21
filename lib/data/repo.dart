import 'dart:async';

import 'package:antassistant/data/net.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:sqflite/sqflite.dart';

abstract class Repository {
  bool isThereAnyAccount();

  void saveUser(Credentials credentials);

  Stream<List<UserData>> getUsersDataStream();
}

class RepositoryImpl extends Repository {
  final List<Credentials> _users = List();
  final StreamController<List<UserData>> _controller = StreamController();
  final Database database;

  RepositoryImpl(this.database);

  @override
  bool isThereAnyAccount() {
    return _users.isNotEmpty;
  }

  @override
  Future<void> saveUser(Credentials credentials) async {
    _users.add(credentials);
    final List<UserData> data = List();
    for (var cr in _users) {
      final d = await getUserData(cr);
      data.add(d);
    }
    _controller.add(data);
  }

  @override
  Stream<List<UserData>> getUsersDataStream() {
    return _controller.stream;
  }
}
