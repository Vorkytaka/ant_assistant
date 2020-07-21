import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/bloc/auth/event.dart' as AuthEvent;
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart' as UserDataEvent;
import 'package:antassistant/bloc/login/bloc.dart';
import 'package:antassistant/bloc/login/event.dart';
import 'package:antassistant/bloc/login/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Авторизация"),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                BlocProvider.of<AuthBloc>(context).add(AuthEvent.AddedUser());
                BlocProvider.of<UserDataBloc>(context)
                    .add(UserDataEvent.AddedUser(state.id));
                Navigator.of(context).pop();
              } else if (state is LoginError) {
                Scaffold.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(SnackBar(
                    content: Text("Не удалось авторизоваться"),
                    duration: Duration(hours: 24),
                  ));
              }
            },
            child: LoginForm(),
          ),
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
                validator: (str) {
                  if (str.isEmpty)
                    return "Имя пользователя не может быть пустым";
                  else
                    return null;
                },
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
                validator: (str) {
                  if (str.isEmpty)
                    return "Пароль не может быть пустым";
                  else
                    return null;
                },
              ),
              SizedBox(height: 10),
              RaisedButton(
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
