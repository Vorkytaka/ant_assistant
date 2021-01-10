import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/bloc/auth/event.dart' as AuthBlocEvent;
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart' as UserDataEvent;
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/screen/detailed/widget/body.dart';
import 'package:antassistant/screen/detailed/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedUserDataScreen extends StatelessWidget {
  final UserData data;
  final ScrollController controller;

  const DetailedUserDataScreen({
    Key key,
    @required this.data,
    this.controller,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DetailedUserDataHeaderWidget(
                    data: data,
                  ),
                ),
              ),
              Flexible(
                child: DetailedUserDataBody(
                  data: data,
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRemoveAccountDialog(BuildContext context, UserData data) {
    return AlertDialog(
      title: Text("Удаление аккаунта"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Вы уверены, что хотите удалить аккаунт ${data.accountName}?"),
          SizedBox(height: 8),
          Text("Это действие нельзя отменить"),
        ],
      ),
      actions: [
        FlatButton(
          child: Text("Нет"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          child: Text("Да"),
          onPressed: () {
            BlocProvider.of<UserDataBloc>(context).add(
                UserDataEvent.DeleteUser(credentialsId: data.credentialsId));
            BlocProvider.of<AuthBloc>(context)
                .add(AuthBlocEvent.DeleteUser(id: data.credentialsId));
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
