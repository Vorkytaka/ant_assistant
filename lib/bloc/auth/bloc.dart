import 'package:antassistant/bloc/auth/state.dart';
import 'package:antassistant/data/repository/repository.dart';
import 'package:bloc/bloc.dart';

import 'event.dart';

class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final Repository _repository;

  AuthBloc(this._repository)
      : assert(_repository != null),
        super(Unauthenticated()) {
    this.add(AppStarted());
  }

  @override
  Stream<AuthBlocState> mapEventToState(AuthBlocEvent event) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState(event);
    } else if (event is DeleteUser) {
      yield* _mapDeleteUserToState(event);
    } else if (event is AddedUser) {
      yield* _mapAddedUserToState(event);
    }
  }

  Stream<AuthBlocState> _mapAppStartedToState(AppStarted event) async* {
    yield* _credentialsToState();
  }

  Stream<AuthBlocState> _mapDeleteUserToState(DeleteUser event) async* {
    await _repository.removeUser(event.id);
    yield* _credentialsToState();
  }

  Stream<AuthBlocState> _mapAddedUserToState(AddedUser event) async* {
    yield* _credentialsToState();
  }

  Stream<AuthBlocState> _credentialsToState() async* {
    final credentials = await _repository.getCredentials();
    if (credentials == null || credentials.isEmpty) {
      yield Unauthenticated();
    } else {
      final mappedCredentials = credentials.map((e) => e.entity).toList();
      yield Authenticated(credentials: mappedCredentials);
    }
  }
}
