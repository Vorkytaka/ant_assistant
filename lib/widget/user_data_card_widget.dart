import 'package:antassistant/entity/user_data.dart';
import 'package:flutter/material.dart';

class UserDataCardWidget extends StatelessWidget {
  final UserData data;
  final GestureTapCallback onTap;

  const UserDataCardWidget({
    Key key,
    @required this.data,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Column(
            children: [
              Text(
                "Имя пользователя",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "${data.accountName}",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Баланс",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${data.balance}",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          "Дней осталось",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${data.daysLeft()}",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
