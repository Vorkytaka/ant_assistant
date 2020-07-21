class UserData {
  final int credentialsId;

  final String accountName;
  final String accountId;
  final String dynDns;

  final double balance;
  final int downloaded;
  final String status;
  final int credit;
  final String smsInfo;

  final String tariffName;
  final String downloadSpeed;
  final String uploadSpeed;
  final double pricePerMonth;

  final double pricePerDay;

  UserData(
      this.credentialsId,
      this.accountName,
      this.accountId,
      this.dynDns,
      this.balance,
      this.downloaded,
      this.status,
      this.credit,
      this.smsInfo,
      this.tariffName,
      this.downloadSpeed,
      this.uploadSpeed,
      this.pricePerMonth)
      : pricePerDay = pricePerMonth / 30;

  @override
  String toString() => "($accountName)";

  int daysLeft() => (balance.toInt() + credit) ~/ pricePerDay.toInt();
}

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
