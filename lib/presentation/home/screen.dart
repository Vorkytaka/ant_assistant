import 'package:animations/animations.dart';
import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/bloc/auth/state.dart';
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/presentation/login/provider.dart';
import 'package:flutter/material.dart';
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
        return Container();
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

/*
class UserDataWidget extends StatefulWidget {
  final Repository repo;

  const UserDataWidget({Key key, this.repo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserDataState();
}

class UserDataState extends State<UserDataWidget> {
  List<UserData> _data;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_data != null && _data.isNotEmpty) {
      if (_data.length > 1) {
        return _buildListOfUserState();
      } else {
        return _buildOneUserState(_data[0]);
      }
    } else {
      return _buildNoUserState();
    }
  }

  Widget _buildNoUserState() {
    return FlatButton(
      onPressed: _onAuth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(Icons.add_circle_outline),
          ),
          Text("Add account"),
        ],
      ),
    );
  }

  Widget _buildListOfUserState() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Material(
                elevation: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            child: Text(
                              "Аккаунты",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: _onAuth,
                          child: Text(
                            "Добавить аккаунт",
                            style: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: _data.length,
                      itemBuilder: (context, pos) {
                        return _buildItem(pos);
                      },
                      separatorBuilder: (context, pos) {
                        return Container(
                          color: Colors.black12,
                          height: 1,
                        );
                      },
                      physics: BouncingScrollPhysics(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildOneUserState(UserData data) {
    return Column(
      children: <Widget>[
        FlatButton(
          onPressed: _onAuth,
          child: Text(
            "Добавить аккаунт",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
        ),
        DetailedUserData(
          data: data,
          repo: widget.repo,
        ),
      ],
    );
  }

  Widget _buildItem(int pos) {
    final data = _data[pos];
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Duration(
        milliseconds: 350,
      ),
      openBuilder: (context, anim) {
        return DetailedUserData(
          data: data,
          repo: this.widget.repo,
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

  void _onAuth() async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginScreenProvider()));
  }
}

class DetailedUserData extends StatelessWidget {
  final UserData data;
  final Repository repo;

  const DetailedUserData({Key key, @required this.data, this.repo})
      : super(key: key);

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
*/
