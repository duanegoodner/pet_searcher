import 'package:flutter/material.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';

import 'package:pet_matcher/screens/landing_screen.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';
import 'package:pet_matcher/widgets/standard_loading_screen.dart';

import 'package:provider/provider.dart';

class StartUpScreenController extends StatelessWidget {
  static const routeName = 'startUpScreenController';
  const StartUpScreenController({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    AppUser user = Provider.of<AppUser>(context);
    if (user == null) {
      return standardLoadingScreen();
    } else if (user.role == 'admin') {
      return AdminHomeScreen();
    } else if (user.role == 'publicUser') {
      return UserHomeScreen();
    }
    return LandingScreen();
  }
}
