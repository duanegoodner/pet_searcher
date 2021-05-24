class NewAppUserDTO {
  String email;
  String firstName;
  String lastName;
  String city;
  String state;
  int zipCode;
  String role = 'publicUser';
  List<String> favorites = <String>[];

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
