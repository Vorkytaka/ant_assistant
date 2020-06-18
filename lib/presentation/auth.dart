import 'package:antassistant/data/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: AuthWidget(),
    );
  }
}

class AuthWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AuthWidgetState();
}

class AuthWidgetState extends State<AuthWidget> {
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Card(
            margin: EdgeInsets.only(left: 20, right: 20),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            elevation: 10,
            shadowColor: Colors.black,
            child: Padding(
                padding: EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 15,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _loginTextController,
                      decoration: InputDecoration(
                          hintText: "Login", border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: "Password", border: OutlineInputBorder()),
                    ),
                    SizedBox(height: 10),
                    MaterialButton(
                      minWidth: double.infinity,
                      color: Colors.blueAccent,
                      height: 50,
                      onPressed: _onAuthButtonClicked,
                      child: Text("Auth"),
                    )
                  ],
                ))));
  }

  Future<void> _onAuthButtonClicked() async {
    final login = _loginTextController.text;
    final pass = _passwordTextController.text;
    final state = await auth(login, pass);

    Navigator.pop(context, state.isSuccess);
  }
}
