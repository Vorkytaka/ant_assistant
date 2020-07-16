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
    if (state is LoginCredentialsValid) {
      yield LoginCredentialsValid(
          event.username, (state as LoginCredentialsValid).password);
    } else {
      yield LoginCredentialsValid(event.username, null);
    }
  }

  Stream<LoginState> _mapLoginPasswordChangedToState(
      LoginPasswordChanged event) async* {
    if (state is LoginCredentialsValid) {
      yield LoginCredentialsValid(
          (state as LoginCredentialsValid).username, event.password);
    } else {
      yield LoginCredentialsValid(null, event.password);
    }
  }

  Stream<LoginState> _mapLoginButtonPressedToState(
      LoginButtonPressed event) async* {
    yield LoginIsLoading();

    final credentials = Credentials(event.username, event.password);
    final isLoginSuccessful = await _repository.login(credentials);

    if (isLoginSuccessful) {
      yield LoginSuccess();
      _repository.saveUser(credentials);
    } else {
      yield LoginError();
    }
  }
}
