import 'package:antassistant/bloc/data/event.dart';
import 'package:antassistant/bloc/data/state.dart';
import 'package:antassistant/data/repository/repository.dart';
import 'package:bloc/bloc.dart';

class UserDataBloc extends Bloc<UserDataEvent, UserDataState> {
  final Repository _repository;

  UserDataBloc(this._repository) : super(DataIsLoading());

  @override
  Stream<UserDataState> mapEventToState(UserDataEvent event) async* {
    if (event is AddedUser) {
      yield* _mapAddedUserToState(event);
    } else if (event is DeleteUser) {
      yield* _mapDeleteUserToState(event);
    } else if (event is AskForUpdate) {
      yield* _mapAskForUpdateToState(event);
    } else if (event is AskForUpdateUser) {
      yield* _mapAskForUpdateUserToState(event);
    }
  }

  Stream<UserDataState> _mapAddedUserToState(AddedUser event) async* {
    final _state = state;

    if (_state is DataLoaded) {
      yield DataIsLoading();

      final credentials = await _repository.getCredentialsById(event.id);
      final data = await _repository.getUserData(credentials);

      yield DataLoaded(
        data: [..._state.data]..add(data),
      );
    }
  }

  Stream<UserDataState> _mapDeleteUserToState(DeleteUser event) async* {
    if (state is DataLoaded) {
      final data = (state as DataLoaded).data;
      yield DataLoaded(
          data: [...data]..removeWhere(
              (element) => element.credentialsId == event.credentialsId));
    }
  }

  Stream<UserDataState> _mapAskForUpdateToState(AskForUpdate event) async* {
    yield DataIsLoading();

    final credentials = await _repository.getCredentials();
    final data =
        await Future.wait(credentials.map((e) => _repository.getUserData(e)));

    yield DataLoaded(data: data);
  }

  Stream<UserDataState> _mapAskForUpdateUserToState(
      AskForUpdateUser event) async* {
    final _state = state;

    if (_state is DataLoaded) {
      yield DataIsLoading();

      final credentials = await _repository.getCredentialsById(event.id);
      final newUserData = await _repository.getUserData(credentials);

      final data = _state.data;
      yield DataLoaded(
        data: List.generate(data.length, (index) {
          final element = data[index];
          if (element.credentialsId == event.id) {
            return newUserData;
          } else {
            return element;
          }
        }),
      );
    }
  }
}
