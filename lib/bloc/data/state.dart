import 'package:antassistant/entity/user_data.dart';
import 'package:meta/meta.dart';

abstract class UserDataState {
  const UserDataState();
}

class DataIsLoading extends UserDataState {
  const DataIsLoading();
}

class DataLoaded extends UserDataState {
  final List<UserData> data;

  // todo: another state for empty data?
  const DataLoaded({@required this.data}) : assert(data != null);
}

class NewUserDataState {
  final UserDataStateStatus status;
  final List<UserData> data;

  NewUserDataState({
    @required this.status,
    this.data,
  }) : assert(status != null);

  NewUserDataState copyWith({
    UserDataStateStatus status,
    List<UserData> data,
  }) {
    return NewUserDataState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}

enum UserDataStateStatus {
  INITIAL,
  LOADING,
  SUCCESS,
  FAILURE,
}
