import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/account_setup_screen.dart';
import 'screens/test_screen.dart';

class PetMatcherApp extends StatelessWidget {
  static final routes = {
    LandingScreen.routeName: (context) => LandingScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    AccountSetupScreen.routeName: (context) => AccountSetupScreen(),
    UserHomeScreen.routeName: (context) => UserHomeScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => fb_auth.FirebaseAuth.instance,
      child: MaterialApp(
        title: 'Pet Matcher',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: TestScreen(),
        // routes: routes,
        // initialRoute: LandingScreen.routeName,
      ),
    );
  }
}
