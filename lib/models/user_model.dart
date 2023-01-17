class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String email;
  final DateTime birthdate;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthdate,
    required this.email,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        birthdate: json['phone'].toDate(),
        email: json['email'],
        phoneNumber: json['phone']);
  }
}
