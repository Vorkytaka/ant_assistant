import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/screen/detailed/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailedUserDataScreenProvider extends StatelessWidget {
  final int credentialsId;
  final ScrollController controller;

  const DetailedUserDataScreenProvider({
    Key key,
    this.credentialsId,
    this.controller,
  })  : assert(credentialsId != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDataBloc, UserDataState>(
      listener: (context, state) {
        if (state is DataLoaded) {
          final data = state._byCredentialsId(credentialsId);
          if (data == null) {
            Navigator.of(context).pop();
          }
        }
      },
      buildWhen: (prev, curr) {
        // we not do a rebuild, if there is no current data
        // cuz it's happening only when we delete this account
        // and hide current dialog
        if (curr is DataLoaded) {
          final data = curr._byCredentialsId(credentialsId);
          if (data == null) {
            return false;
          }
        }

        return true;
      },
      builder: (context, state) {
        if (state is DataLoaded) {
          final data = state._byCredentialsId(credentialsId);
          assert(data != null);
          return DetailedUserDataScreen(
            data: data,
            controller: controller,
          );
        } else if (state is DataIsLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return Container();
      },
    );
  }
}

extension DataLoadedUtils on DataLoaded {
  static final _orElseNull = () => null;

  UserData _byCredentialsId(int id) {
    return this.data.firstWhere(
          (e) => e.credentialsId == id,
          orElse: _orElseNull,
        );
  }
}
