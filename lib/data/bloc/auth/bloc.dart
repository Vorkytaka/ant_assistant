import 'package:antassistant/data/bloc/auth/state.dart';
import 'package:antassistant/data/repository/repository.dart';
import 'package:bloc/bloc.dart';

import 'event.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final Repository _repository;

  AuthBloc(this._repository) : super(Unauthenticated());

  @override
  Stream<AuthBlocState> mapEventToState(AuthBlocEvent event) async* {
    print("object");
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    }
  }

  Stream<AuthBlocState> _mapAppStartedToState(AppStarted event) async* {
    final credentials = await _repository.getCredentials();
    if (credentials == null || credentials.isEmpty) {
      yield Unauthenticated();
    } else {
      yield Authenticated(credentials);
    }
  }
}
