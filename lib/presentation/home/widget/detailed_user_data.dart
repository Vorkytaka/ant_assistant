import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/bloc/auth/event.dart' as AuthEvent;
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart' as UserDataEvent;
import 'package:antassistant/entity/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedUserData extends StatelessWidget {
  final UserData data;

  const DetailedUserData({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          data.accountName,
          style: TextStyle(color: Colors.black54),
        ),
        elevation: 0,
        backgroundColor: Colors.grey[50],
        iconTheme: IconThemeData(color: Colors.black54),
      ),
      body: Builder(builder: (context) {
        return SafeArea(
          child: Container(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Код плательщика",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        data.accountId,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Clipboard.setData(ClipboardData(
                            text: data.accountId,
                          ));
                          Scaffold.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                              content: Text(
                                  "Код плательщика скопирован в буфер обмена"),
                              duration: Duration(seconds: 5),
                            ));
                        },
                        icon: Icon(
                          Icons.content_copy,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          final bool isDeleted = await showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Удалить аккаунт?"),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("Нет"),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    RaisedButton(
                                      child: Text("Да"),
                                      onPressed: () {
                                        BlocProvider.of<AuthBloc>(context)
                                            .add(AuthEvent.DeleteUser(data.id));
                                        BlocProvider.of<UserDataBloc>(context)
                                            .add(UserDataEvent.DeleteUser(
                                                data.id));
                                        Navigator.pop(context, true);
                                      },
                                    )
                                  ],
                                );
                              });
                          if (isDeleted != null && isDeleted) {
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.delete_forever,
                          size: 20,
                          color: Colors.black54,
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Text("Учетная запись"),
                  Text(data.accountName),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Баланс"),
                            Text("${data.balance.toStringAsFixed(1)} ₽"),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Дней осталось"),
                            Text("${data.daysLeft()}"),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Text("Кредит доверия"),
                  Text("${data.credit} ₽"),
                  Divider(),
                  Text("Название тарифа"),
                  Text("${data.tariffName}"),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Цена за месяц"),
                            Text("${data.pricePerMonth.toStringAsFixed(1)} ₽"),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Цена за день"),
                            Text("${data.pricePerDay.toStringAsFixed(1)} ₽"),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Скорость скачивания"),
                            Text("${data.downloadSpeed}"),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text("Скорость отдачи"),
                            Text("${data.uploadSpeed}"),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Text("Скачано за текущий месяц"),
                  Text("${data.downloaded} Мб"),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
