import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'file:///C:/Users/Vorkytaka/AndroidStudioProjects/ant_assistant/lib/data/repository/repository_impl.dart';

import 'presentation/main.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDatabase();
    return _database;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANTAssistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(
        repo: RepositoryImpl(database),
      ),
    );
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), "ant.db"),
      version: 1,
      onCreate: (Database db, int v) async {
        await db.execute(UsersDB.EXECUTE_CREATE_TABLE);
      },
    );
  }
}

class UsersDB {
  static const String TABLE_NAME = "users";
  static const String COLUMN_NAME_USER_ID = "user_id";
  static const String COLUMN_NAME_LOGIN = "login";
  static const String COLUMN_NAME_PASSWORD = "password";

  static const String EXECUTE_CREATE_TABLE = """
        CREATE TABLE ${UsersDB.TABLE_NAME}(
          ${UsersDB.COLUMN_NAME_USER_ID} INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
          ${UsersDB.COLUMN_NAME_LOGIN} TEXT NOT NULL, 
          ${UsersDB.COLUMN_NAME_PASSWORD} TEXT NOT NULL
          );
        """;
}
