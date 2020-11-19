abstract class UserDataEvent {
  const UserDataEvent();
}

class AddedUser extends UserDataEvent {
  final int id;

  const AddedUser({this.id});
}

class DeleteUser extends UserDataEvent {
  final int credentialsId;

  const DeleteUser({this.credentialsId});
}

class AskForUpdate extends UserDataEvent {
  const AskForUpdate();
}

class AskForUpdateUser extends UserDataEvent {
  final int id;

  const AskForUpdateUser({this.id});
}
