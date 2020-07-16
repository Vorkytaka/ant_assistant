import 'dart:async';

import 'package:antassistant/data/api.dart';
import 'package:antassistant/data/repository/repository.dart';
import 'package:antassistant/data/source/data_source.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/id_entity.dart';
import 'package:antassistant/entity/user_data.dart';

class RepositoryImpl extends Repository {
  final DataSource _dataSource;
  final Api _api;

  RepositoryImpl(this._dataSource, this._api);

  @override
  Future<bool> isThereAnyAccount() async {
    return (await _dataSource.getCredentials()).isNotEmpty;
  }

  @override
  Future<void> saveUser(Credentials credentials) async {
    await _dataSource.insertCredentials(credentials);
  }

  @override
  Future<void> removeUser(int id) async {
    await _dataSource.removeCredentials(id);
  }

  @override
  Future<List<IDEntity<Credentials>>> getCredentials() async {
    return await _dataSource.getCredentials();
  }

  @override
  Future<bool> login(Credentials credentials) async {
    return await _api.login(credentials);
  }

  @override
  Future<UserData> getUserData(IDEntity<Credentials> credentials) async {
    return await _api.getUserData(credentials);
  }
}
