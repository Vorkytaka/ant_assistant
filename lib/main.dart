import 'package:antassistant/data/user_data.dart';
import 'package:flutter/material.dart';

import 'presentation/screens.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainScreen(
        repo: RepositoryImpl(),
      ),
    );
  }
}
