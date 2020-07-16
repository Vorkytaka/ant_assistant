import 'package:animations/animations.dart';
import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/bloc/auth/state.dart';
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/presentation/login/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ANTAssistant"),
        actions: <Widget>[
          FlatButton(
            onPressed: () async {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => LoginScreenProvider()));
            },
            child: Text(
              "Добавить аккаунт",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthBlocState>(
        builder: (BuildContext context, AuthBlocState state) {
          if (state is Authenticated) {
            return AuthenticatedWidget();
          } else if (state is Unauthenticated) {
            return UnauthenticatedWidget();
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class AuthenticatedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // todo: New Bloc for User's data
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (BuildContext context, UserDataState state) {
        if (state is DataIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DataFetched) {
          return ListView.separated(
            itemCount: state.data.length,
            separatorBuilder: (context, i) => Container(
              color: Colors.grey,
              height: 1,
            ),
            itemBuilder: (context, i) => _buildItem(state.data[i]),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildItem(UserData data) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Duration(
        milliseconds: 350,
      ),
      openBuilder: (context, anim) {
        return DetailedUserData(
          data: data,
        );
      },
      closedBuilder: (context, anim) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.accountName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Баланс: ${data.balance} ₽",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class UnauthenticatedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Вы ещё не добавили аккаунт"),
    );
  }
}

class DetailedUserData extends StatelessWidget {
  final UserData data;

  const DetailedUserData({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  },
                  icon: Icon(
                    Icons.content_copy,
                    size: 20,
                    color: Colors.black54,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
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
                                  // todo: remove account
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        });
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
    );
  }
}
