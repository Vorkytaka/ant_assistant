import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/screen/detailed/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedUserDataPageViewScreen extends StatelessWidget {
  static final String ROUTE = "DetailedUserDataPageViewScreen";

  /// [credentialsId] uses for select initial page
  /// if it's [null] then initial page will be the first page
  final int credentialsId;

  const DetailedUserDataPageViewScreen({
    Key key,
    this.credentialsId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserDataBloc, NewUserDataState>(
        builder: (context, state) {
          if (state.status == UserDataStateStatus.SUCCESS) {
            int initialPage = 0;
            if (credentialsId != null) {
              for (int i = 0; i < state.data.length; i++) {
                if (state.data[i].credentialsId == credentialsId) {
                  initialPage = i;
                  break;
                }
              }
            }
            return PageView.builder(
              controller: PageController(initialPage: initialPage),
              itemCount: state.data.length,
              itemBuilder: (context, i) {
                return DetailedUserDataScreen(data: state.data[i]);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
