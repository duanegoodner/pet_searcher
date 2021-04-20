import 'package:flutter/material.dart';
import 'package:pet_matcher/screens/landing_screen.dart';

import '../models/app_user.dart';
import '../services/firebase_auth_service.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';

  UserHomeScreen({Key key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final _firebaseAuth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    final AppUser appUser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        leading: Container(),
        title: Text(
          'User Homescreen',
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Log Out',
            onPressed: _logout,
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('User Info:'),
              Text('Name: ${appUser.firstName} ${appUser.lastName}'),
              Text('email: ${appUser.email}'),
              Text('User Type: ${appUser.role}'),
              Text('City: ${appUser.city}'),
              Text('State: ${appUser.state}'),
              Text('User Zip Code: ${appUser.zipCode.toString()}'),
            ],
          ),
        ),
      ),
    );
  }

  void _logout() async {
    await _firebaseAuth.firebaseSignOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
