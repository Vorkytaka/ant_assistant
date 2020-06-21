class UserData {
  final String accountName;
  final String userId;
  final String dynDns;

  final double balance;
  final int downloaded;
  final bool status;
  final int credit;
  final bool smsInfo;

  final String tariffName;
  final String downloadSpeed;
  final String uploadSpeed;
  final double pricePerMonth;

  final double pricePerDay;

  UserData(
      this.accountName,
      this.userId,
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
