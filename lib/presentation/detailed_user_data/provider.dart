import 'package:antassistant/presentation/detailed_user_data/detailed_user_data.dart';
import 'package:flutter/material.dart';

class DetailedUserDataScreenProvider extends StatelessWidget {
  final int credentialsId;

  const DetailedUserDataScreenProvider({Key key, this.credentialsId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailedUserDataScreen(
      credentialsId: credentialsId,
    );
  }
}
