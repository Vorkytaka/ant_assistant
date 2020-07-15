import 'package:antassistant/data/source/sql_data_source.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import 'data/repository/repository_impl.dart';
import 'presentation/main.dart';

void main() {
  runApp(App());
}

/*class AppProvider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AppProviderState();
}

class AppProviderState extends State<AppProvider> {
  bool _initialized = false;
  Repository repository;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initMainWidget();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) return Container();
    return App();
  }

  Future<void> _initMainWidget() async {
    if (_initialized) return;

    // init all main things here

    setState(() {
      _initialized = true;
    });
  }
}*/

class App extends StatelessWidget {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await SQLDataSource.initDatabase();
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
}
