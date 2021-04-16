class NewAppUserDTO {
  String email;
  String firstName;
  String lastName;
  String city;
  String state;
  int zipCode;
  String role = 'publicUser';

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
