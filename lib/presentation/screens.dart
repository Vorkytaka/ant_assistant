import 'package:flutter/material.dart';

import 'file:///C:/Users/Vorkytaka/AndroidStudioProjects/ant_assistant/lib/data/data.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AuthScreen()));
        },
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _loginTextController,
              decoration: InputDecoration(hintText: "Login"),
            ),
            TextField(
              controller: _passwordTextController,
              obscureText: true,
              decoration: InputDecoration(hintText: "Password"),
            ),
            MaterialButton(
              onPressed: _onAuthButtonClicked,
              child: Text("Auth"),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _onAuthButtonClicked() async {
    final login = _loginTextController.text;
    final pass = _passwordTextController.text;
    final state = await auth(login, pass);

    Navigator.pop(context, state.isSuccess);
  }
}
