import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/bloc/auth/event.dart' as AuthBlocEvent;
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart' as UserDataEvent;
import 'package:antassistant/entity/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class URIs {
  const URIs._();

  // ignore: non_constant_identifier_names
  static final SUPPORT_PHONE = Uri(
    scheme: "tel",
    path: "+7 495 940-92-11",
  );
}

class Dialogs {
  const Dialogs._();

  static Widget _buildRemoveAccountDialog(
    BuildContext context,
    UserData data,
  ) {
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
