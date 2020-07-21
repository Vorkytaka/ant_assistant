abstract class UserDataEvent {
  const UserDataEvent();
}

class AddedUser extends UserDataEvent {
  final int id;

  const AddedUser({this.id});
}

class DeleteUser extends UserDataEvent {
  final int id;

  const DeleteUser({this.id});
}

class AskForUpdate extends UserDataEvent {
  const AskForUpdate();
}

class AskForUpdateUser extends UserDataEvent {
  final int id;

  const AskForUpdateUser({this.id});
}
