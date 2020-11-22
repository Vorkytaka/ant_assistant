import 'package:antassistant/bloc/data/bloc.dart';
import 'package:antassistant/bloc/data/event.dart' as UserDataEvent;
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/entity/user_data.dart';
import 'package:antassistant/screen/detailed/screen.dart';
import 'package:antassistant/screen/login/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ANTAssistant"),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(LoginScreenProvider.ROUTE);
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<UserDataBloc>(context)
                  .add(UserDataEvent.AskForUpdate());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<UserDataBloc, UserDataState>(
                builder: (BuildContext context, UserDataState state) {
                  if (state is DataIsLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is DataLoaded) {
                    return ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, i) => _buildItem(
                        context,
                        state.data[i],
                      ),
                      physics: ScrollPhysics(),
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

  Widget _buildItem(
    BuildContext context,
    UserData data,
  ) {
    return Card(
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) {
              return DraggableScrollableSheet(
                minChildSize: 0.3,
                maxChildSize: 0.9,
                initialChildSize: 0.5,
                expand: false,
                builder: (context, controller) => DetailedUserDataScreen(
                  credentialsId: data.credentialsId,
                  controller: controller,
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data.accountName}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "${data.accountId}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              Text(
                "${data.statusInfo.balance} ₽",
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
