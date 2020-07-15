import 'package:antassistant/data/source/sql_data_source.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'file:///C:/Users/Vorkytaka/AndroidStudioProjects/ant_assistant/lib/data/repository/repository_impl.dart';

import 'data/source/naming/user_scheme.dart';
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
        repo: RepositoryImpl(SQLDataSource(database)),
      ),
    );
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), "ant.db"),
      version: 1,
      onCreate: (Database db, int v) async {
        await db.execute(UsersScheme.EXECUTE_CREATE_TABLE);
      },
    );
  }
}
