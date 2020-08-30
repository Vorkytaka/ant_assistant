import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/widget/user_data_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedScreen extends StatelessWidget {
  final UserData data;

  const DetailedScreen({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
          ),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () async {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    BlocProvider.of<UserDataBloc>(context)
                        .add(AskForUpdateUser(id: data.credentialsId));
                  },
                ),
              ],
            ),
            Hero(
              tag: "user_data_${data.accountId}",
              child: UserDataCardWidget(
                data: data,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Номер счёта",
              style: Theme.of(context).textTheme.headline5,
            ),
            Row(
              children: [
                Text(
                  "${data.accountId}",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Builder(
                  builder: (BuildContext context) => IconButton(
                    onPressed: () {
                      Clipboard.setData(ClipboardData(
                        text: data.accountId,
                      ));
                      Scaffold.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          content:
                              Text("Код плательщика скопирован в буфер обмена"),
                          duration: Duration(seconds: 5),
                        ));
                    },
                    icon: Icon(
                      Icons.content_copy,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
