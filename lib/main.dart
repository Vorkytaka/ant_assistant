import 'package:antassistant/bloc/auth/state.dart';
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart';
import 'package:antassistant/data/api.dart';
import 'package:antassistant/data/source/sql_data_source.dart';
import 'package:antassistant/screen/home/provider.dart';
import 'package:antassistant/screen/login/provider.dart';
import 'package:antassistant/screen/unauthenticated/screen.dart';
import 'package:antassistant/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'bloc/auth/bloc.dart';
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(repository),
            lazy: false,
          ),
          BlocProvider<UserDataBloc>(
            create: (context) => UserDataBloc(repository)..add(AskForUpdate()),
            lazy: false,
          ),
        ],
        child: App(),
      ),
    );
  }

  Future<void> _initMainWidget() async {
    if (_initialized) return;

    final db = await SQLDataSource.initDatabase();
    final dataSource = SQLDataSource(db);
    final api = Api();
    repository = RepositoryImpl(dataSource, api);

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
      theme: createLightTheme(),
      themeMode: ThemeMode.system,
      routes: {
        HomeScreenProvider.ROUTE: (context) => HomeScreenProvider(),
        LoginScreenProvider.ROUTE: (context) => LoginScreenProvider(),
        UnauthenticatedScreen.ROUTE: (context) => UnauthenticatedScreen(),
      },
      home: BlocBuilder<AuthBloc, AuthBlocState>(
        builder: (BuildContext context, AuthBlocState state) {
          if (state is Authenticated) {
            return HomeScreenProvider();
          } else if (state is Unauthenticated) {
            return UnauthenticatedScreen();
          } else {
            return Container();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
