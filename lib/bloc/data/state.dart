import 'package:antassistant/entity/user_data.dart';
import 'package:meta/meta.dart';

class UserDataState {
  final UserDataStateStatus status;
  final List<UserData> data;

  UserDataState({
    @required this.status,
    this.data,
  }) : assert(status != null);

  UserDataState copyWith({
    UserDataStateStatus status,
    List<UserData> data,
  }) {
    return UserDataState(
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
