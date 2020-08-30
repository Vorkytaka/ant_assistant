import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/screen/detailed/provider.dart';
import 'package:antassistant/widget/user_data_card_widget.dart';
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
          return ListView.builder(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            itemCount: state.data.length,
            itemBuilder: (context, i) => UserDataCardWidget(
              data: state.data[i],
              onTap: () async {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) {
                    return DetailedScreenProvider(data: state.data[i]);
                  },
                ));
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
