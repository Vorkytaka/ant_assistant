import 'package:meta/meta.dart';

@immutable
class UserData {
  final int credentialsId;

  final String accountName;
  final String accountId;
  final String dynDns;

  final TariffInfo tariffInfo;

  final StatusInfo statusInfo;

  UserData(
    this.credentialsId,
    this.accountName,
    this.accountId,
    this.dynDns,
    this.tariffInfo,
    this.statusInfo,
  );

  @override
  String toString() => "($accountName)";

  int daysLeft() =>
      (statusInfo.balance.toInt() + statusInfo.credit) ~/
      tariffInfo.pricePerDay.toInt();
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

/*
extension DBUserData on UserData {
  Map<String, dynamic> toMap() => {
        "accountName": accountName,
        "accountId": accountId,
        "dynDns": dynDns,
        "balance": balance,
        "downloaded": downloaded,
        "status": status,
        "credit": credit,
        "smsInfo": smsInfo,
        "tariffName": tariffName,
        "downloadSpeed": downloadSpeed,
        "uploadSpeed": uploadSpeed,
        "pricePerMonth": pricePerMonth,
      };

  Map<String, dynamic> toMapWithId(int id) => {
        "user_id": id,
        "accountName": accountName,
        "accountId": accountId,
        "dynDns": dynDns,
        "balance": balance,
        "downloaded": downloaded,
        "status": status,
        "credit": credit,
        "smsInfo": smsInfo,
        "tariffName": tariffName,
        "downloadSpeed": downloadSpeed,
        "uploadSpeed": uploadSpeed,
        "pricePerMonth": pricePerMonth,
      };
}
*/
