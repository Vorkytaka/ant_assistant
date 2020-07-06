import 'package:antassistant/data/repo.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
      title: 'Flutter Demo',
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
        await db.execute("""
        CREATE TABLE users(
          user_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
          login TEXT NOT NULL, 
          password TEXT NOT NULL
          );
        """);
      },
    );
  }
}
