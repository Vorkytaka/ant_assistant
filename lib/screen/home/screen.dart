import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/screen/detailed/provider.dart';
import 'package:antassistant/widget/user_data_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
            BlocBuilder<UserDataBloc, UserDataState>(
              builder: (BuildContext context, UserDataState state) {
                if (state is DataIsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DataLoaded) {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      itemCount: state.data.length,
                      itemBuilder: (context, i) => Hero(
                        tag: "user_data_${state.data[i].accountId}",
                        child: UserDataCardWidget(
                          data: state.data[i],
                          onTap: () async {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                                return DetailedScreenProvider(
                                    data: state.data[i]);
                              },
                            ));
                          },
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
