abstract class SignupState {
  const SignupState();
}

class SignupInitial extends SignupState {}

class SignUpInProgress extends SignupState {}

class SignUpSuccess extends SignupState {}

class SignUpFailure extends SignupState {
  final String reason;

  const SignUpFailure({required this.reason});
}
