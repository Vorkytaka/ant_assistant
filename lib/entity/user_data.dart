class UserData {
  final String accountName;
  final String userId;
  final String dynDns;
  final double balance;

  UserData(this.accountName, this.userId, this.dynDns, this.balance);

  @override
  String toString() => "($accountName, $balance)";
}
