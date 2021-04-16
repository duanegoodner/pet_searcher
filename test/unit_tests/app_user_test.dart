import 'package:flutter_test/flutter_test.dart';
import 'package:pet_matcher/models/app_user.dart';

void main() {
  group('app_user model unit test: ', () {
    final String email = 'fake@gmail.com';
    final String firstName = 'Mickey';
    final String lastName = 'Mouse';
    final String city = 'Orlando';
    final String state = 'Florida';
    final int zipCode = 60000;
    final String role = 'user';

    test('App user created from JSON should have appropriate values', () {
      final user = AppUser.fromJSON({
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'city': city,
        'state': state,
        'zipCode': zipCode,
        'role': role,
      });

      expect(user.email, email);
      expect(user.firstName, firstName);
      expect(user.lastName, lastName);
      expect(user.city, city);
      expect(user.state, state);
      expect(user.zipCode, zipCode);
      expect(user.role, role);
    });

    test('App user created from constructer should have appropriate values',
        () {
      final user =
          AppUser(email: email, firstName: firstName, lastName: lastName, 
          city: city, state: state, zipCode: zipCode, role: role);
      
      expect(user.email, email);
      expect(user.firstName, firstName);
      expect(user.lastName, lastName);
      expect(user.city, city);
      expect(user.state, state);
      expect(user.zipCode, zipCode);
      expect(user.role, role);
    });

  });
  
}
