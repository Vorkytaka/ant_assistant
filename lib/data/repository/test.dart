import 'dart:math';

import 'package:antassistant/data/repository/repository.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/id_entity.dart';
import 'package:antassistant/entity/user_data.dart';

class TestRepository extends Repository {
  static final Random _random = Random();

  final List<Credentials> _credentials = [
    Credentials(username: "123", password: "321"),
    Credentials(username: "1234", password: "4321"),
    Credentials(username: "12345", password: "54321"),
  ];

  @override
  Future<List<IDEntity<Credentials>>> getCredentials() async {
    return List.generate(
      _credentials.length,
      (index) => IDEntity(id: index, entity: _credentials[index]),
    );
  }

  @override
  Future<IDEntity<Credentials>> getCredentialsById(int id) async {
    return IDEntity(id: id, entity: _credentials[id]);
  }

  @override
  Future<UserData> getUserData(IDEntity<Credentials> credentials) async {
    return _generateUserData(credentials.id, credentials.entity);
  }

  @override
  Future<bool> isThereAnyAccount() async {
    return _credentials.isNotEmpty;
  }

  @override
  Future<bool> login(Credentials credentials) async {
    return true;
  }

  @override
  Future<void> removeUser(int id) async {
    _credentials.removeAt(id);
  }

  @override
  Future<int> saveUser(Credentials credentials) async {
    _credentials.add(credentials);
    return _credentials.length - 1;
  }

  static UserData _generateUserData(int id, Credentials credentials) {
    final statusInfo = StatusInfo(
      balance: _random.nextInt(5000).toDouble(),
      downloaded: _random.nextInt(90000),
      status: "Активна",
      credit: _random.nextInt(4) * 100,
      smsInfo: "Включено",
    );
    final tariffInfo = TariffInfo(
      tariffName: "AX_PRO_SUPER_${_random.nextInt(5)}",
      downloadSpeed: "${_random.nextInt(100)}",
      uploadSpeed: "${_random.nextInt(100)}",
      pricePerMonth: _random.nextInt(1000).toDouble(),
    );
    return UserData(
      credentialsId: id,
      accountName: "NOUA_${_random.nextInt(10)}_${_random.nextInt(900)}",
      accountId: "${_random.nextInt(10000)}",
      dynDns: "my-dyn-dns",
      tariffInfo: tariffInfo,
      statusInfo: statusInfo,
    );
  }
}
