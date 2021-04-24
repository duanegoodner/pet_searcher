import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

//import '../models/app_user.dart';

class TestScreen extends StatelessWidget {
  static const routeName = 'testScreen';

  const TestScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseAuth =
        Provider.of<fb_auth.FirebaseAuth>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        leading: Container(),
        title: Text(
          'Test Screen for Firebase User Info',
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
        child: StreamBuilder(
          stream: firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('FIrbase Info:'),
                  Text('email: ${snapshot.data?.email}'),
                  Text('User ID: ${snapshot.data?.uid}'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _logout(context) async {
    await Provider.of<fb_auth.FirebaseAuth>(context, listen: false).signOut();
  }
}
