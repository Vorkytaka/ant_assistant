import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    BlocProvider.of<UserDataBloc>(context).add(AskForUpdate());
                  },
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<UserDataBloc, UserDataState>(
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
                      itemBuilder: (context, i) => Text("${state.data[i].accountName}"),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
