import 'dart:async';

import 'package:antassistant/data/net.dart';
import 'package:antassistant/entity/IDEntity.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:sqflite/sqflite.dart';

import '../main.dart';

abstract class Repository {
  Future<bool> isThereAnyAccount();

  void saveUser(Credentials credentials);

  Stream<List<UserData>> getUsersDataStream();

  void removeUser(int id);
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

  @override
  void removeUser(int id) async {
    await _removeCredentials(id);
    _update();
  }

  Future<void> _update() async {
    final users = await _getCredentials();
    final data = await Future.wait(users.map((e) {
      return getUserData(e);
    }));
    _controller.add(data);
  }

  Future<List<IDEntity<Credentials>>> _getCredentials() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(UsersDB.TABLE_NAME);
    return List.generate(maps.length, (i) {
      return IDEntity(
        maps[i][UsersDB.COLUMN_NAME_USER_ID],
        Credentials(
          maps[i][UsersDB.COLUMN_NAME_LOGIN],
          maps[i][UsersDB.COLUMN_NAME_PASSWORD],
        ),
      );
    });
  }

  Future<void> _insertCredentials(Credentials user) async {
    final db = await database;
    await db.insert(
      UsersDB.TABLE_NAME,
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> _removeCredentials(int id) async {
    final db = await database;
    await db.delete(
      UsersDB.TABLE_NAME,
      where: "${UsersDB.COLUMN_NAME_USER_ID} = ?",
      whereArgs: [id],
    );
  }
}
