import 'package:antassistant/data/source/data_source.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/id_entity.dart';
import 'package:sqflite/sqflite.dart';

import 'naming/user_scheme.dart';

class SQLDataSource extends DataSource {
  final Future<Database> database;

  SQLDataSource(this.database);

  @override
  Future<List<IDEntity<Credentials>>> getCredentials() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(UsersScheme.TABLE_NAME);
    return List.generate(maps.length, (i) {
      return IDEntity(
        maps[i][UsersScheme.COLUMN_NAME_USER_ID],
        Credentials(
          maps[i][UsersScheme.COLUMN_NAME_LOGIN],
          maps[i][UsersScheme.COLUMN_NAME_PASSWORD],
        ),
      );
    });
  }

  @override
  Future<void> insertCredentials(Credentials credentials) async {
    final db = await database;
    await db.insert(
      UsersScheme.TABLE_NAME,
      credentials.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeCredentials(int id) async {
    final db = await database;
    await db.delete(
      UsersScheme.TABLE_NAME,
      where: "${UsersScheme.COLUMN_NAME_USER_ID} = ?",
      whereArgs: [id],
    );
  }
}
