abstract class AuthBlocEvent {
  const AuthBlocEvent();
}

class AppStarted extends AuthBlocEvent {
  const AppStarted();
}

class DeleteUser extends AuthBlocEvent {
  final int id;

  const DeleteUser(this.id);
}
