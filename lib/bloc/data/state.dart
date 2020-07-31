import 'package:antassistant/entity/user_data.dart';

abstract class UserDataState {
  const UserDataState();
}

class DataIsLoading extends UserDataState {
  const DataIsLoading();
}

class DataLoaded extends UserDataState {
  final List<UserData> data;

  const DataLoaded({this.data});
}
