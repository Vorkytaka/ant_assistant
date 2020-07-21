import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/id_entity.dart';

abstract class DataSource {
  Future<List<IDEntity<Credentials>>> getCredentials();

  Future<int> insertCredentials(Credentials credentials);

  Future<void> removeCredentials(int id);

  Future<IDEntity<Credentials>> getCredentialsById(int id);
}
