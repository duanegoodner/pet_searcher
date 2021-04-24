import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/services/app_user_service.dart';

class UserHomeScreen extends StatelessWidget {
  static const routeName = 'userHomeScreen';

  @override
  Widget build(BuildContext context) {
    Stream<DocumentSnapshot> appUserDataStream =
        locator<AppUserService>().userDataStream;
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
            onPressed: () {
              _logout(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: appUserDataStream,
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return CircularProgressIndicator();
              } else {
                AppUser currentUser = AppUser.fromJSON(snapshot.data.data());
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User Info:'),
                    Text(
                        'Name: ${currentUser?.firstName} ${currentUser?.lastName}'),
                    Text('email: ${currentUser?.email}'),
                    Text('User Type: ${currentUser?.role}'),
                    Text('City: ${currentUser?.city}'),
                    Text('State: ${currentUser?.state}'),
                    Text('User Zip Code: ${currentUser?.zipCode.toString()}'),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    await locator<AppUserService>().firebaseAuth.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}
