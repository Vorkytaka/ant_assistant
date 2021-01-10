import 'package:antassistant/entity/user_data.dart';
import 'package:flutter/material.dart';

class DetailedUserDataBody extends StatelessWidget {
  final UserData data;
  final ScrollController controller;

  const DetailedUserDataBody({
    Key key,
    @required this.data,
    this.controller,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
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
}
