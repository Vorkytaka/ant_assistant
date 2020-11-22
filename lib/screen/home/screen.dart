import 'package:antassistant/bloc/auth/bloc.dart';
import 'package:antassistant/bloc/auth/event.dart' as AuthBlocEvent;
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart' as UserDataEvent;
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/screen/login/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ANTAssistant"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(LoginScreenProvider.ROUTE);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<UserDataBloc>(context)
                  .add(UserDataEvent.AskForUpdate());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<UserDataBloc, UserDataState>(
                builder: (BuildContext context, UserDataState state) {
                  if (state is DataIsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DataLoaded) {
                    return ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, i) => _buildItem(
                        context,
                        state.data[i],
                      ),
                      physics: ScrollPhysics(),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    UserData data,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) {
              return Flexible(
                child: DraggableScrollableSheet(
                  minChildSize: 0.3,
                  maxChildSize: 0.9,
                  initialChildSize: 0.5,
                  expand: false,
                  builder: (context, controller) => DetailedUserDataWidget(
                    credentialsId: data.credentialsId,
                    controller: controller,
                  ),
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Text(
            "${data.accountName}",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ),
    );
  }
}

class DetailedUserDataWidget extends StatelessWidget {
  final int credentialsId;
  final ScrollController controller;

  const DetailedUserDataWidget({
    Key key,
    @required this.credentialsId,
    this.controller,
  })  : assert(credentialsId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDataBloc, UserDataState>(
      listener: (context, state) {
        if (state is DataLoaded) {
          final data = state.data.firstWhere(
            (element) => element.credentialsId == credentialsId,
            orElse: () => null,
          );
          if (data == null) {
            Navigator.of(context).pop();
          }
        }
      },
      buildWhen: (prev, curr) {
        // we not do a rebuild, if there is no current data
        // cuz it's happening only when we delete this account
        // and hide current dialog
        if (curr is DataLoaded) {
          final data = curr.data.firstWhere(
            (element) => element.credentialsId == credentialsId,
            orElse: () => null,
          );
          if (data == null) {
            return false;
          }
        }

        return true;
      },
      builder: (context, state) {
        if (state is DataLoaded) {
          final data = state.data.firstWhere(
            (element) => element.credentialsId == credentialsId,
            orElse: () => null,
          );
          assert(data != null);

          return Container(
            color: Theme.of(context).cardColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              verticalDirection: VerticalDirection.up,
              children: [
                Flexible(
                  child: ListView(
                    controller: controller,
                    physics: const ScrollPhysics(),
                    padding: const EdgeInsets.only(
                      bottom: 16,
                    ),
                    children: [
                      SizedBox(width: 16),
                      _buildInfoCard(
                        context,
                        Icons.account_balance_wallet,
                        "Баланс",
                        data.statusInfo.balance.toString(),
                      ),
                      _buildInfoCard(
                        context,
                        Icons.calendar_today_outlined,
                        "Дней осталось",
                        data.daysLeft.toString(),
                      ),
                      _buildInfoCard(
                        context,
                        Icons.volunteer_activism,
                        "Кредит доверия",
                        data.statusInfo.credit.toString(),
                      ),
                      _buildInfoCard(
                        context,
                        Icons.credit_card_rounded,
                        "Код плательщика",
                        data.accountId,
                      ),
                      _buildInfoCard(
                        context,
                        Icons.wb_sunny_rounded,
                        "Состояние",
                        data.statusInfo.status,
                      ),
                      _buildInfoCard(
                        context,
                        Icons.label_important,
                        "Название тарифа",
                        data.tariffInfo.tariffName,
                      ),
                      _buildInfoCard(
                        context,
                        Icons.attach_money_outlined,
                        "Цена за месяц",
                        data.tariffInfo.pricePerMonth.toString(),
                      ),
                      _buildInfoCard(
                        context,
                        Icons.attach_money_outlined,
                        "Цена за день",
                        data.tariffInfo.pricePerDay.toString(),
                      ),
                      _buildInfoCard(
                        context,
                        Icons.download_rounded,
                        "Скачано за текущий месяц",
                        data.statusInfo.downloaded.toString(),
                      ),
                      _buildInfoCard(
                        context,
                        Icons.arrow_forward,
                        "Скорость загрузки",
                        data.tariffInfo.downloadSpeed,
                      ),
                      _buildInfoCard(
                        context,
                        Icons.arrow_back,
                        "Скорость отдачи",
                        data.tariffInfo.uploadSpeed,
                      ),
                      _buildInfoCard(
                        context,
                        Icons.dynamic_feed,
                        "Ваш DynDNS",
                        data.dynDns,
                      ),
                    ],
                  ),
                ),
                AppBar(
                  elevation: 3,
                  title: Text(
                    "${data.accountName}",
                    // style: Theme.of(context).textTheme.headline5,
                  ),
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      tooltip: "Изменить данные аккаунта",
                      onPressed: null,
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_forever_rounded),
                      tooltip: "Удалить аккаунт",
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              _buildRemoveAccountDialog(context, data),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        } else if (state is DataIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container();
      },
    );
  }

  Widget _buildInfoCard(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            SizedBox(width: 16),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
                SizedBox(width: 8),
                Text(
                  value,
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            ),
          ],
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
