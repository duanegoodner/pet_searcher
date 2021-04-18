import 'package:flutter/material.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';
import 'screens/add_pet_screen.dart';
import 'screens/landing_screen.dart';
import 'screens/login_screen.dart';
import 'screens/account_setup_screen.dart';

class PetMatcherApp extends StatelessWidget {
  static final routes = {
    LandingScreen.routeName: (context) => LandingScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    AccountSetupScreen.routeName: (context) => AccountSetupScreen(),
    AddPetScreen.routeName: (context) => AddPetScreen(),
    UserHomeScreen.routeName: (context) => UserHomeScreen(),
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
      //initialRoute: AddPetScreen.routeName,
    );
  }
}
