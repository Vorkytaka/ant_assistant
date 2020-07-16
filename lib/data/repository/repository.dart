import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/id_entity.dart';
import 'package:antassistant/entity/user_data.dart';

abstract class Repository {
  Future<bool> login(Credentials credentials);

  Future<bool> isThereAnyAccount();

  Future<int> saveUser(Credentials credentials);

  Future<void> removeUser(int id);

  Future<List<IDEntity<Credentials>>> getCredentials();

  Future<UserData> getUserData(IDEntity<Credentials> credentials);
}
