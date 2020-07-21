import 'package:animations/animations.dart';
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detailed_user_data.dart';

class AuthenticatedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (BuildContext context, UserDataState state) {
        if (state is DataIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DataFetched) {
          return ListView.separated(
            itemCount: state.data.length,
            separatorBuilder: (context, i) => Container(
              color: Colors.grey,
              height: 1,
            ),
            itemBuilder: (context, i) => _buildItem(state.data[i]),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildItem(UserData data) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Duration(
        milliseconds: 350,
      ),
      openBuilder: (context, anim) {
        return DetailedUserData(
          data: data,
        );
      },
      closedBuilder: (context, anim) {
        return Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 24,
            ),
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
        );
      },
    );
  }
}
