import 'package:antassistant/data/repository/repository.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:bloc/bloc.dart';

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

abstract class AuthBlocEvent {
  const AuthBlocEvent();
}

class AppStarted extends AuthBlocEvent {
  const AppStarted();
}

// ---
abstract class AuthBlocState {
  const AuthBlocState();
}

class Unauthenticated extends AuthBlocState {
  const Unauthenticated();
}

class Authenticated extends AuthBlocState {
  final List<Credentials> credentials;

  const Authenticated(this.credentials);
}
