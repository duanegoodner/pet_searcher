import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';

class PetSearcherApp extends StatelessWidget {
  static final routes = {
    LandingScreen.routeName: (context) => LandingScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    //AccountSetupScreen.routeName: (context) => AccountSetupScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Matcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: routes,
      initialRoute: LandingScreen.routeName,
    );
  }
}
