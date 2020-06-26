import 'dart:async';

import 'package:antassistant/data/net.dart';
import 'package:antassistant/entity/IDEntity.dart';
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
    _pushCachedData();
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
    final data = await Future.wait(users.map((e) {
      return getUserData(e.entity);
    }));
    _controller.add(data);
    data.forEach((element) {
      _insertUserData(element);
    });
  }

  Future<void> _pushCachedData() async {
    final cached = await _getUserDatas();
    _controller.add(cached);
  }

  Future<List<IDEntity<Credentials>>> _getCredentials() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("users");
    return List.generate(maps.length, (i) {
      return IDEntity(
        maps[i]["user_id"],
        Credentials(maps[i]['login'], maps[i]["password"]),
      );
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

  Future<List<UserData>> _getUserDatas() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query("user_data");
    return List.generate(maps.length, (i) {
      return UserData(
        maps[i]["accountName"],
        maps[i]["accountId"],
        maps[i]["dynDns"],
        maps[i]["balance"],
        maps[i]["downloaded"],
        maps[i]["status"],
        maps[i]["credit"],
        maps[i]["smsInfo"],
        maps[i]["tariffName"],
        maps[i]["downloadSpeed"],
        maps[i]["uploadSpeed"],
        maps[i]["pricePerMonth"],
      );
    });
  }

  Future<void> _insertUserData(UserData data) async {
    final db = await database;
    // TODO: Don't make query for each insert
    final maps = (await db.query(
      "users",
      where: "login = ? COLLATE NOCASE",
      whereArgs: [data.accountName],
    ));
    if (maps.isNotEmpty) {
      final int id = maps[0]["user_id"];
      await db.insert(
        "user_data",
        data.toMapWithId(id),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
