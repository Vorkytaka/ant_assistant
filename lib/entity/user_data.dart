import 'package:meta/meta.dart';

@immutable
class UserData {
  final int credentialsId;

  final String accountName;
  final String accountId;
  final String dynDns;

  final TariffInfo tariffInfo;

  final StatusInfo statusInfo;

  final int daysLeft;

  UserData({
    @required this.credentialsId,
    @required this.accountName,
    @required this.accountId,
    @required this.dynDns,
    @required this.tariffInfo,
    @required this.statusInfo,
  }) : daysLeft =
            (statusInfo.balance + statusInfo.credit) ~/ tariffInfo.pricePerDay;

  @override
  String toString() => "UserData($accountName)";
}

@immutable
class TariffInfo {
  final String tariffName;
  final String downloadSpeed;
  final String uploadSpeed;
  final double pricePerMonth;
  final double pricePerDay;

  TariffInfo({
    @required this.tariffName,
    @required this.downloadSpeed,
    @required this.uploadSpeed,
    @required this.pricePerMonth,
  }) : pricePerDay = pricePerMonth / 30;
}

@immutable
class StatusInfo {
  final double balance;
  final int downloaded;
  final String status;
  final int credit;
  final String smsInfo;

  StatusInfo({
    @required this.balance,
    @required this.downloaded,
    @required this.status,
    @required this.credit,
    @required this.smsInfo,
  });
}
