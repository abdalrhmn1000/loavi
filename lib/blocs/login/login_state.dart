abstract class LoginState {
  const LoginState();
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String reason;

  const LoginFailure({required this.reason});
}
