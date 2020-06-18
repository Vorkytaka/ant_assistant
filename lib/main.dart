import 'package:antassistant/data/repo.dart';
import 'package:flutter/material.dart';

import 'presentation/main.dart';

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
