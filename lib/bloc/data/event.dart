abstract class UserDataEvent {
  const UserDataEvent();
}

class AddedUser extends UserDataEvent {
  final int id;

  const AddedUser({this.id});
}

// todo: research
// maybe should delete this event?
// looks like AuthBloc DeleteUser event enough
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
