abstract class UserDataEvent {
  const UserDataEvent();
}

class AddedUser extends UserDataEvent {
  // todo: id of user
  const AddedUser();
}

class DeleteUser extends UserDataEvent {
  const DeleteUser();
}

class AskForUpdate extends UserDataEvent {
  const AskForUpdate();
}
