import 'package:antassistant/data/repo.dart';
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
  List<UserData> _data;

  @override
  void initState() {
    super.initState();
    this.widget.repo.getUsersDataStream().listen(_onNextUsersData);
    if (!this.widget.repo.isThereAnyAccount()) {
      Future(() {
        onAuth();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _getBaseView(),
    );
  }

  Widget _getBaseView() {
    if (_data != null && _data.isNotEmpty) {
      return PageView.builder(
        itemBuilder: (context, pos) {
          return _buildPage(pos);
        },
        itemCount: _data.length,
      );
    } else {
      return _buildAddUserScreen();
    }
  }

  Widget _buildAddUserScreen() {
    return FlatButton(
      onPressed: onAuth,
      child: Text("Add user"),
    );
  }

  Widget _buildPage(int pos) {
    final data = _data[pos];
    return Text(data.accountName);
  }

  void _onNextUsersData(List<UserData> data) {
    setState(() {
      _data = data;
    });
  }

  void onAuth() async {
    final AuthState state = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthScreen()));

    if (state != null && state.isSuccess) {
      this.widget.repo.saveUser(state.credentials);
    }
  }
}
