abstract class LoginEvent {
  const LoginEvent();
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});
}

class LogoutRequested extends LoginEvent {}
