import 'dart:async';

abstract class Repository {
  bool isThereAnyAccount();

  void saveUser(String username, String password);

  Stream<List<UserData>> getUsersDataStream();
}

class RepositoryImpl extends Repository {
  final List<Credential> _users = List();
  final StreamController<List<UserData>> _controller = StreamController();

  @override
  bool isThereAnyAccount() {
    return _users.isNotEmpty;
  }

  @override
  void saveUser(String username, String password) {
    _users.add(Credential(username, password));
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

class Credential {
  final String login;
  final String password;

  Credential(this.login, this.password);
}

class UserData {
  final String accountName;
  final String userId;
  final String dynDns;
  final double balance;

  UserData(this.accountName, this.userId, this.dynDns, this.balance);
}
