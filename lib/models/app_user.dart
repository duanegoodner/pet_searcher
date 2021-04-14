import 'package:intl/intl.dart';

class AppUser {
  final String email;
  final String firstName;
  final String lastName;
  final int zipCode;
  final String role;

  AppUser({
    this.email,
    this.firstName,
    this.lastName,
    this.zipCode,
    this.role,
  });

  factory AppUser.fromJSON(Map<String, dynamic> json) {
    return AppUser(
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      zipCode: json['zipCode'],
      role: json['role'],
    );
  }
}
