abstract class SignupEvent {
  const SignupEvent();
}

class SignUpRequested extends SignupEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String gender;
  final String birthDate;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.gender,
    required this.birthDate,
  });
}
