import 'dart:async';

import 'package:antassistant/data/net.dart';
import 'package:antassistant/data/repository/repository.dart';
import 'package:antassistant/data/source/data_source.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/user_data.dart';

class RepositoryImpl extends Repository {
  final StreamController<List<UserData>> _controller = StreamController();
  final DataSource _dataSource;

  RepositoryImpl(this._dataSource) {
    _update();
  }

  @override
  Future<bool> isThereAnyAccount() async {
    return (await _dataSource.getCredentials()).isNotEmpty;
  }

  @override
  Future<void> saveUser(Credentials credentials) async {
    await _dataSource.insertCredentials(credentials);
    _update();
  }

  @override
  Stream<List<UserData>> getUsersDataStream() {
    return _controller.stream;
  }

  @override
  void removeUser(int id) async {
    await _dataSource.removeCredentials(id);
    _update();
  }

  @override
  Future<List<Credentials>> getCredentials() async {
    final credentialsWithId = await _dataSource.getCredentials();
    return List.generate(
        credentialsWithId.length, (index) => credentialsWithId[index].entity);
  }

  Future<void> _update() async {
    final users = await _dataSource.getCredentials();
    final data = await Future.wait(users.map((e) {
      return getUserData(e);
    }));
    _controller.add(data);
  }

  @override
  Future<bool> login(Credentials credentials) async {
    return await auth(credentials);
  }
}
