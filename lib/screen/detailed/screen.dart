import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/widget/user_data_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailedScreen extends StatelessWidget {
  final UserData data;

  const DetailedScreen({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          UserDataCardWidget(
            data: data,
          )
        ],
      ),
    );
  }
}
