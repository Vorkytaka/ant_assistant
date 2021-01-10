import 'package:antassistant/entity/user_data.dart';
import 'package:flutter/material.dart';

class DetailedUserDataHeaderWidget extends StatelessWidget {
  final UserData data;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;

  const DetailedUserDataHeaderWidget({
    Key key,
    @required this.data,
    this.actions,
    this.automaticallyImplyLeading = true,
  })  : assert(data != null),
        assert(automaticallyImplyLeading != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget leading;
    if (automaticallyImplyLeading) {
      if (Navigator.of(context).canPop()) {
        leading = BackButton();
      }
    }

    if (leading == null) {
      leading = Container();
    }

    return Card(
      elevation: 3,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "На счету",
                  style: Theme.of(context).textTheme.headline5,
                ),
                SizedBox(height: 8),
                Text(
                  "${data.statusInfo.balance}",
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Дней осталось",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "${data.daysLeft}",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Кредит доверия",
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        SizedBox(height: 8),
                        Text(
                          "${data.statusInfo.credit}",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leading,
              if (actions != null && actions.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
