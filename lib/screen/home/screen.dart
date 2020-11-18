import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/screen/login/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              BlocProvider.of<UserDataBloc>(context).add(AskForUpdate());
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
              return DraggableScrollableSheet(
                minChildSize: 0.3,
                maxChildSize: 0.9,
                initialChildSize: 0.5,
                builder: (context, controller) => DetailedUserDataWidget(
                  accountId: data.accountId,
                  controller: controller,
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
  final String accountId;
  final ScrollController controller;

  const DetailedUserDataWidget(
      {Key key, @required this.accountId, this.controller})
      : assert(accountId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (context, state) {
        if (state is DataLoaded) {
          final data = state.data.firstWhere(
              (element) => element.accountId == accountId,
              orElse: null);
          assert(data != null);

          return Container(
            color: Theme.of(context).cardColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${data.accountName}",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Flexible(
                  child: ListView(
                    controller: controller,
                    physics: const ScrollPhysics(),
                    children: [
                      SizedBox(width: 16),
                      _buildInfoCard(
                          context, "Баланс", data.balance.toString()),
                      _buildInfoCard(
                          context, "Дней осталось", data.daysLeft().toString()),
                      _buildInfoCard(
                          context, "Кредит доверия", data.credit.toString()),
                      _buildInfoCard(
                          context, "Код плательщика", data.accountId),
                      _buildInfoCard(context, "Состояние", data.status),
                      _buildInfoCard(
                          context, "Название тарифа", data.tariffName),
                      _buildInfoCard(context, "Цена за месяц",
                          data.pricePerMonth.toString()),
                      _buildInfoCard(
                          context, "Цена за день", data.pricePerDay.toString()),
                      _buildInfoCard(context, "Скачано за текущий месяц",
                          data.downloaded.toString()),
                      _buildInfoCard(
                          context, "Скорость загрузки", data.downloadSpeed),
                      _buildInfoCard(
                          context, "Скорость отдачи", data.uploadSpeed),
                      _buildInfoCard(context, "Ваш DynDNS", data.dynDns),
                    ],
                  ),
                )
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
    String title,
    String value,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(width: 8),
              Text(
                value,
                style: Theme.of(context).textTheme.headline4,
              )
            ],
          ),
        ),
      ),
    );
  }
}
