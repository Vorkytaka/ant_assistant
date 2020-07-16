import 'package:antassistant/bloc/login/bloc.dart';
import 'package:antassistant/data/repository/repository.dart';
import 'package:antassistant/presentation/login/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class LoginScreenProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Repository repository = Provider.of<Repository>(context);
    return BlocProvider<LoginBloc>(
      create: (BuildContext context) => LoginBloc(repository),
      child: LoginScreen(),
    );
  }
}
