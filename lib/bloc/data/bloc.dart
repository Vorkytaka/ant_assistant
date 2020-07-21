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
    if (state is DataFetched) {
      final credentials = await _repository.getCredentialsById(event.id);
      final data = await _repository.getUserData(credentials);

      yield DataFetched(
        [...(state as DataFetched).data]..add(data),
      );
    }
  }

  Stream<UserDataState> _mapDeleteUserToState(DeleteUser event) async* {
    if (state is DataFetched) {
      final data = (state as DataFetched).data;
      yield DataFetched([...data]
        ..removeWhere((element) => element.credentialsId == event.id));
    }
  }

  Stream<UserDataState> _mapAskForUpdateToState(AskForUpdate event) async* {
    yield DataIsLoading();

    final credentials = await _repository.getCredentials();
    final data =
        await Future.wait(credentials.map((e) => _repository.getUserData(e)));

    yield DataFetched(data);
  }

  Stream<UserDataState> _mapAskForUpdateUserToState(
      AskForUpdateUser event) async* {
    if (state is DataFetched) {
      final credentials = await _repository.getCredentialsById(event.id);
      final newUserData = await _repository.getUserData(credentials);

      final data = (state as DataFetched).data;
      yield DataFetched(List.generate(data.length, (index) {
        final element = data[index];
        if (element.credentialsId == event.id) {
          return newUserData;
        } else {
          return element;
        }
      }));
    }
  }
}
