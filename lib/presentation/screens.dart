import 'package:antassistant/data/user_data.dart';
import 'package:antassistant/entity/auth_state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth.dart';

class MainScreen extends StatelessWidget {
  final Repository repo;

  const MainScreen({Key key, this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: UserDataWidget(
        repo: repo,
      ),
    );
  }
}

class UserDataWidget extends StatefulWidget {
  final Repository repo;

  const UserDataWidget({Key key, this.repo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserDataState();
}

class UserDataState extends State<UserDataWidget> {
  String _text = "There is no";

  @override
  void initState() {
    super.initState();
    this.widget.repo.getUsersDataStream().listen(onNextUsersData);
//    if (!this.widget.repo.isThereAnyAccount()) {
//      onAuth();
//    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(_text),
          FlatButton(
            onPressed: onAuth,
            child: Text("Add Account"),
          ),
        ],
      ),
    );
  }

  void onNextUsersData(List<UserData> data) {
    setState(() {
      _text = data.map((e) => e.accountName).join(", ");
    });
  }

  void onAuth() async {
    final AuthState state = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthScreen()));

    if (state.isSuccess) {
      this.widget.repo.saveUser(state.credentials);
    }
  }
}
