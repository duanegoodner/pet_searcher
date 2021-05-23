//import 'package:intl/intl.dart';

class AppUser {
  String email;
  String firstName;
  String lastName;
  String city;
  String state;
  int zipCode;
  String role = 'publicUser';
  List<dynamic> favorites = <String>[];

  AppUser({
    this.email,
    this.firstName,
    this.lastName,
    this.city,
    this.state,
    this.zipCode,
    this.role,
    this.favorites,
  });

  AppUser.initial()
      : email = '',
        firstName = '',
        lastName = '',
        city = '',
        state = '',
        zipCode = 0,
        role = '',
        favorites = [];

  AppUser.fromJSON(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zipCode'];
    role = json['role'];
    favorites = json['favorites'];
  }

  Map<String, dynamic> toJson() => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'role': role,
        'favorites': favorites,
      };
}
