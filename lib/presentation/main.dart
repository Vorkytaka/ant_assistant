import 'package:antassistant/data/repo.dart';
import 'package:antassistant/entity/auth_state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auth.dart';

class MainScreen extends StatelessWidget {
  final Repository repo;

  const MainScreen({Key key, this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: UserDataWidget(
          repo: repo,
        ),
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
    this.widget.repo.isThereAnyAccount().then((value) {
      if (!value) {
        onAuth();
      }
    });
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
      return ListView.builder(
        itemBuilder: (context, pos) {
          return _buildItem(pos);
        },
        itemCount: _data.length + 1,
      );
    } else {
      return _buildAddUserScreen();
    }
  }

  Widget _buildAddUserScreen() {
    return FlatButton(
      onPressed: onAuth,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.zero),
      ),
      child: Row(
//        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            onPressed: null,
            icon: Icon(Icons.add_circle_outline),
          ),
          Text("Add account"),
        ],
      ),
    );
  }

  Widget _buildItem(int pos) {
    if (pos < _data.length) {
      final data = _data[pos];
      return _buildUserDataItem(data);
    } else {
      return _buildAddUserScreen();
    }
  }

  Widget _buildUserDataItem(UserData data) {
    return Card(
      color: Colors.white,
      shadowColor: Colors.black,
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return DetailedUserData(data: data);
              });
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.accountName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Баланс: ${data.balance} ₽",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onNextUsersData(List<UserData> data) {
    setState(() {
      _data = data;
    });
  }

  void onAuth() async {
    final AuthState state = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: false,
//      enableDrag: false,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: AuthWidget(),
      ),
    );

    if (state != null && state.isSuccess) {
      this.widget.repo.saveUser(state.credentials);
    }
  }
}

class DetailedUserData extends StatelessWidget {
  final UserData data;

  const DetailedUserData({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Код плательщика",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  data.accountId,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(
                      text: data.accountId,
                    ));
                  },
                  icon: Icon(
                    Icons.content_copy,
                    size: 20,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
