import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/services/app_user_service.dart';

import 'package:pet_matcher/screens/account_setup_screen.dart';
import 'package:pet_matcher/screens/add_pet_screen.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/screens/landing_screen.dart';
import 'package:pet_matcher/screens/login_screen.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';

class Navigation {
  static final routes = {
    LandingScreen.routeName: (context) => LandingScreen(),
    LoginScreen.routeName: (context) => LoginScreen(),
    AccountSetupScreen.routeName: (context) => AccountSetupScreen(),
    AddPetScreen.routeName: (context) => AddPetScreen(),
    UserHomeScreen.routeName: (context) => UserHomeScreen(),
    AdminHomeScreen.routeName: (context) => AdminHomeScreen(),
  };

  // static Route<dynamic> generateRoute(RouteSettings settings) {
  //   switch (settings.name) {
  //     case LandingScreen.routeName:
  //       return MaterialPageRoute(builder: (_) => LandingScreen());
  //     case LoginScreen.routeName:
  //       return MaterialPageRoute(builder: (_) => LoginScreen());
  //     case AccountSetupScreen.routeName:
  //       return MaterialPageRoute(builder: (_) => AccountSetupScreen());
  //     case AddPetScreen.routeName:
  //       return MaterialPageRoute(builder: (_) => AddPetScreen());
  //     case UserHomeScreen.routeName:
  //       return MaterialPageRoute(builder: (_) => UserHomeScreen());
  //     case AdminHomeScreen.routeName:
  //       return MaterialPageRoute(builder: (_) => AdminHomeScreen());
  //     default:
  //       return MaterialPageRoute(
  //         builder: (_) => Scaffold(
  //           body: Center(
  //             child: Text('No route defined for ${settings.name}'),
  //           ),
  //         ),
  //       );
  //   }
  // }

}
