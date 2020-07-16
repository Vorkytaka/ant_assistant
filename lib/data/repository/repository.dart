import 'package:antassistant/entity/credentials.dart';

abstract class Repository {
  Future<bool> login(Credentials credentials);

  Future<bool> isThereAnyAccount();

  void saveUser(Credentials credentials);

  Future<void> removeUser(int id);

  Future<List<Credentials>> getCredentials();
}
