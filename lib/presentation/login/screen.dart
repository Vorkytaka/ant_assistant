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
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              BlocProvider.of<AuthBloc>(context).add(AuthEvent.AddedUser());
              BlocProvider.of<UserDataBloc>(context)
                  .add(UserDataEvent.AddedUser(id: state.id));
              Navigator.of(context).pop();
            } else if (state is LoginError) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text("Не удалось авторизоваться"),
                  duration: Duration(hours: 24),
                ));
            }
            // todo: on error request focus to username field
          },
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  String _username;
  String _password;

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (BuildContext context, LoginState state) {
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofocus: true,
                focusNode: _usernameFocus,
                onChanged: (String str) {
                  return BlocProvider.of<LoginBloc>(context)
                      .add(LoginUsernameChanged(username: str));
                },
                onSaved: (String str) {
                  _username = str;
                },
                decoration: InputDecoration(
                  labelText: "Имя пользователя",
                ),
                validator: (str) {
                  if (str.isEmpty)
                    return "Имя пользователя не может быть пустым";
                  else
                    return null;
                },
                onFieldSubmitted: (String str) {
                  _usernameFocus.unfocus();
                  _passwordFocus.requestFocus();
                },
              ),
              SizedBox(height: 8),
              TextFormField(
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  focusNode: _passwordFocus,
                  onChanged: (String str) {
                    return BlocProvider.of<LoginBloc>(context)
                        .add(LoginPasswordChanged(password: str));
                  },
                  onSaved: (String str) {
                    _password = str;
                  },
                  decoration: InputDecoration(
                    labelText: "Пароль",
                  ),
                  validator: (str) {
                    if (str.isEmpty)
                      return "Пароль не может быть пустым";
                    else
                      return null;
                  },
                  onFieldSubmitted: (String str) {
                    _askForLogin();
                  }),
              SizedBox(height: 8),
              RaisedButton(
                onPressed: (state is LoginIsLoading)
                    ? null : _askForLogin,
                child: (state is LoginIsLoading)
                    ? CircularProgressIndicator()
                    : Text("Войти"),
              )
            ],
          ),
        );
      },
    );
  }

  void _askForLogin() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      BlocProvider.of<LoginBloc>(context)
          .add(LoginButtonPressed(
        username: _username,
        password: _password,
      ));
    }
  }
}
