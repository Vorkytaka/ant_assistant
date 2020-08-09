import 'package:antassistant/bloc/login/event.dart';
import 'package:antassistant/bloc/login/state.dart';
import 'package:antassistant/data/repository/repository.dart';
import 'package:antassistant/entity/credentials.dart';
import 'package:bloc/bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Repository _repository;

  LoginBloc(this._repository) : super(LoginIsEmpty());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginUsernameChanged) {
      yield* _mapLoginUsernameChangesToState(event);
    } else if (event is LoginPasswordChanged) {
      yield* _mapLoginPasswordChangedToState(event);
    } else if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedToState(event);
    }
  }

  Stream<LoginState> _mapLoginUsernameChangesToState(
      LoginUsernameChanged event) async* {
    final _state = state;
    if (_state is LoginCredentialsValid) {
      yield LoginCredentialsValid(
        username: event.username,
        password: _state.password,
      );
    } else {
      yield LoginCredentialsValid(
        username: event.username,
        password: null,
      );
    }
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(
      LoginPasswordChanged event) async* {
    final _state = state;
    if (_state is LoginCredentialsValid) {
      yield LoginCredentialsValid(
        username: _state.username,
        password: event.password,
      );
    } else {
      yield LoginCredentialsValid(
        username: null,
        password: event.password,
      );
    }
  }

  Stream<LoginState> _mapLoginButtonPressedToState(
      LoginButtonPressed event) async* {
    yield LoginIsLoading();

    final credentials = Credentials(
      login: event.username,
      password: event.password,
    );
    final isLoginSuccessful = await _repository.login(credentials);

    if (isLoginSuccessful) {
      final id = await _repository.saveUser(credentials);
      yield LoginSuccess(id: id);
    } else {
      yield LoginError();
    }
  }
}
