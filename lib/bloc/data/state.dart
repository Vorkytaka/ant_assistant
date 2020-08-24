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
