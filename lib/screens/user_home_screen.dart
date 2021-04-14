import 'package:flutter/material.dart';

import '../models/app_user.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';

  UserHomeScreen({Key key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final AppUser appUser = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        leading: BackButton(),
        title: Text(
          'User Homescreen',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Info:'),
            Text('Name: ${appUser.firstName} ${appUser.lastName}'),
            Text('email: ${appUser.email}'),
            Text('User Type: ${appUser.role}'),
            Text('User Zip Code: ${appUser.zipCode.toString()}'),
          ],
        ),
      ),
    );
  }
}
