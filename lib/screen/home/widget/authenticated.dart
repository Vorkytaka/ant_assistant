import 'package:animations/animations.dart';
import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/screen/detailed_user_data/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticatedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataState>(
      builder: (BuildContext context, UserDataState state) {
        if (state is DataIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is DataLoaded) {
          return ListView.separated(
            itemCount: state.data.length,
            separatorBuilder: (context, i) => Container(
              color: Colors.grey,
              height: 1,
            ),
            itemBuilder: (context, i) => _buildItem(state.data[i], context),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildItem(UserData data, BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      transitionDuration: Duration(
        milliseconds: 300,
      ),
      tappable: false,
      openColor: Theme.of(context).cardColor,
      openBuilder: (context, anim) {
        return DetailedUserDataScreenProvider(
          credentialsId: data.credentialsId,
        );
      },
      closedShape: const RoundedRectangleBorder(),
      closedColor: Theme.of(context).cardColor,
      closedBuilder: (context, openContainer) {
        return Card(
          shape: const RoundedRectangleBorder(),
          margin: EdgeInsets.zero,
          child: InkWell(
            onTap: openContainer,
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
          ),
        );
      },
    );
  }
}
