import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/screen/detailed/screen.dart';
import 'package:flutter/material.dart';

class DetailedScreenProvider extends StatelessWidget {
  final UserData data;

  const DetailedScreenProvider({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DetailedScreen(
      data: data,
    );
  }
}
