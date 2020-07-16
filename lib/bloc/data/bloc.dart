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
    }
  }

  Stream<UserDataState> _mapAddedUserToState(AddedUser event) async* {
    yield* _userDataToState();
  }

  Stream<UserDataState> _mapDeleteUserToState(DeleteUser event) async* {
    yield* _userDataToState();
  }

  Stream<UserDataState> _mapAskForUpdateToState(AskForUpdate event) async* {
    yield* _userDataToState();
  }

  Stream<UserDataState> _userDataToState() async* {
    yield DataIsLoading();

    final credentials = await _repository.getCredentials();
    final data =
        await Future.wait(credentials.map((e) => _repository.getUserData(e)));

    yield DataFetched(data);
  }
}
