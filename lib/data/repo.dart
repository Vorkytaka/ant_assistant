import 'dart:async';

import 'package:antassistant/data/net.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:sqflite/sqflite.dart';

abstract class Repository {
  Future<bool> isThereAnyAccount();

  void saveUser(Credentials credentials);

  Stream<List<UserData>> getUsersDataStream();
}

class RepositoryImpl extends Repository {
  final StreamController<List<UserData>> _controller = StreamController();
  final Future<Database> database;

  RepositoryImpl(this.database) {
    _update();
  }

  @override
  Future<bool> isThereAnyAccount() async {
    return (await _getCredentials()).isNotEmpty;
  }

  @override
  Future<void> saveUser(Credentials credentials) async {
    await _insertCredentials(credentials);
    _update();
  }

  @override
  Stream<List<UserData>> getUsersDataStream() {
    return _controller.stream;
  }

  Future<void> _update() async {
    final users = await _getCredentials();
    final datas = await Future.wait(users.map((e) {
      return getUserData(e);
    }));
    _controller.add(datas);
  }

  Future<List<Credentials>> _getCredentials() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("users");
    return List.generate(maps.length, (i) {
      return Credentials(maps[i]['login'], maps[i]["password"]);
    });
  }

  Future<void> _insertCredentials(Credentials user) async {
    final db = await database;
    await db.insert(
      "users",
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
