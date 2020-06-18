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
      this.pricePerMonth);

  @override
  String toString() => "($accountName)";
}
