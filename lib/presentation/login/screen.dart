import 'package:antassistant/bloc/login/bloc.dart';
import 'package:antassistant/bloc/login/event.dart';
import 'package:antassistant/bloc/login/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.of(context).pop();
            }
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  String _username;
  String _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, LoginState state) {
        return Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: true,
                onChanged: (String str) {
                  return BlocProvider.of<LoginBloc>(context)
                      .add(LoginUsernameChanged(str));
                },
                onSaved: (String str) {
                  _username = str;
                },
                decoration: InputDecoration(
                  hintText: "Имя пользователя",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                obscureText: true,
                textInputAction: TextInputAction.next,
                autofocus: true,
                onChanged: (String str) {
                  return BlocProvider.of<LoginBloc>(context)
                      .add(LoginPasswordChanged(str));
                },
                onSaved: (String str) {
                  _password = str;
                },
                decoration: InputDecoration(
                  hintText: "Пароль",
                ),
              ),
              SizedBox(height: 10),
              MaterialButton(
                minWidth: double.infinity,
                color: Colors.blueAccent,
                height: 50,
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    BlocProvider.of<LoginBloc>(context)
                        .add(LoginButtonPressed(_username, _password));
                  }
                },
                child: Text("Войти"),
              )
            ],
          ),
        );
      },
    );
  }
}
