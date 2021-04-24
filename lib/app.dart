import 'package:flutter/material.dart';
import 'package:pet_matcher/navigation/routes.dart';

import 'package:pet_matcher/screens/add_pet_screen.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';
import 'package:pet_matcher/screens/landing_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/locator.dart';

import 'package:pet_matcher/navigation/navigation.dart';

class PetMatcherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Matcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: startupScreenSelector(context),
      routes: RouteNames.routes,
    );
  }
}

Widget startupScreenSelector(BuildContext context) {
  return FutureBuilder(
    future: locator<AppUserService>().userRole,
    builder: (context, snapshot) {
      if (snapshot.data == 'admin') {
        return AdminHomeScreen();
      }
      if (snapshot.data == 'publicUser') {
        return UserHomeScreen();
      }
      return LandingScreen();
    },
  );
}
