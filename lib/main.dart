import 'package:antassistant/data/bloc/auth/bloc.dart';
import 'package:antassistant/data/source/sql_data_source.dart';
import 'package:antassistant/presentation/home/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'data/bloc/auth/event.dart';
import 'data/repository/repository.dart';
import 'data/repository/repository_impl.dart';

void main() {
  runApp(AppProvider());
}

class AppProvider extends StatefulWidget {
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
    if (!_initialized) {
      return Container();
    }

    return Provider.value(
      value: repository,
      updateShouldNotify: (previous, current) => false,
      child: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(repository)..add(AppStarted()),
        child: App(),
      ),
    );
  }

  Future<void> _initMainWidget() async {
    if (_initialized) return;

    final db = await SQLDataSource.initDatabase();
    final dataSource = SQLDataSource(db);
    repository = RepositoryImpl(dataSource);

    setState(() {
      _initialized = true;
    });
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ANTAssistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeScreenProvider(),
    );
  }
}
