//import 'package:intl/intl.dart';

class AppUser {
  String email;
  String firstName;
  String lastName;
  String city;
  String state;
  int zipCode;
  String role;

  AppUser({
    this.email,
    this.firstName,
    this.lastName,
    this.city,
    this.state,
    this.zipCode,
    this.role,
  });

  AppUser.initial()
      : email = '',
        firstName = '',
        lastName = '',
        city = '',
        state = '',
        zipCode = 0,
        role = '';

  AppUser.fromJSON(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'role': role,
      };
}
