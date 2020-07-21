abstract class UserDataEvent {
  const UserDataEvent();
}

class AddedUser extends UserDataEvent {
  // todo: id of user
  const AddedUser();
}

class DeleteUser extends UserDataEvent {
  final int id;

  const DeleteUser(this.id);
}

class AskForUpdate extends UserDataEvent {
  const AskForUpdate();
}
