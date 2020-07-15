import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/user_data.dart';

abstract class Repository {
  Future<bool> isThereAnyAccount();

  void saveUser(Credentials credentials);

  Stream<List<UserData>> getUsersDataStream();

  void removeUser(int id);

  Future<List<Credentials>> getCredentials();
}
