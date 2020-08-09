import 'package:antassistant/data/source/data_source.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:antassistant/entity/id_entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'naming/user_scheme.dart';

class SQLDataSource extends DataSource {
  static const String _DB_FILE_NAME = "ant.db";

  final Database database;

  SQLDataSource(this.database);

  static Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _DB_FILE_NAME),
      version: 1,
      onCreate: (Database db, int v) async {
        await db.execute(UsersScheme.EXECUTE_CREATE_TABLE);
      },
    );
  }

  @override
  Future<List<IDEntity<Credentials>>> getCredentials() async {
    final db = database;
    final List<Map<String, dynamic>> maps =
        await db.query(UsersScheme.TABLE_NAME);
    return List.generate(maps.length, (i) {
      return IDEntity(
        id: maps[i][UsersScheme.COLUMN_NAME_ID],
        entity: Credentials(
          username: maps[i][UsersScheme.COLUMN_NAME_LOGIN],
          password: maps[i][UsersScheme.COLUMN_NAME_PASSWORD],
        ),
      );
    });
  }

  @override
  Future<int> insertCredentials(Credentials credentials) async {
    final db = database;
    return await db.insert(
      UsersScheme.TABLE_NAME,
      credentials.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> removeCredentials(int id) async {
    final db = database;
    await db.delete(
      UsersScheme.TABLE_NAME,
      where: "${UsersScheme.COLUMN_NAME_ID} = ?",
      whereArgs: [id],
    );
  }

  @override
  Future<IDEntity<Credentials>> getCredentialsById(int id) async {
    final db = database;
    final maps = await db.query(
      UsersScheme.TABLE_NAME,
      where: "${UsersScheme.COLUMN_NAME_ID} = ?",
      whereArgs: [id],
    );

    if (maps.isEmpty) {
      return null;
    } else {
      return IDEntity(
        id: maps[0][UsersScheme.COLUMN_NAME_ID],
        entity: Credentials(
          username: maps[0][UsersScheme.COLUMN_NAME_LOGIN],
          password: maps[0][UsersScheme.COLUMN_NAME_PASSWORD],
        ),
      );
    }
  }
}
