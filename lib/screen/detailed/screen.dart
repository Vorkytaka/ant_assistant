import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/screen/detailed/widget/body.dart';
import 'package:antassistant/screen/detailed/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedUserDataScreen extends StatelessWidget {
  final UserData data;
  final ScrollController controller;

  const DetailedUserDataScreen({
    Key key,
    @required this.data,
    this.controller,
  })  : assert(data != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: DetailedUserDataHeaderWidget(
                    data: data,
                  ),
                ),
              ),
              Flexible(
                child: DetailedUserDataBody(
                  data: data,
                  controller: controller,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailedUserPagesScreen extends StatelessWidget {
  /// [credentialsId] uses for select initial page
  /// if it's [null] then initial page will be the first page
  final int credentialsId;

  const DetailedUserPagesScreen({
    Key key,
    this.credentialsId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserDataBloc, UserDataState>(
        builder: (context, state) {
          if (state is DataLoaded) {
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
