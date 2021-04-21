import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';

import 'package:pet_matcher/services/app_user_service.dart';

import 'package:pet_matcher/widgets/standard_loading_screen.dart';

Widget userHomeScreenSelector(BuildContext context) {
  return FutureBuilder(
      future: Provider.of<AppUserService>(context).userRole,
      builder: (context, snapshot) {
        if (snapshot.data == 'admin') {
          return AdminHomeScreen();
        } else if (snapshot.data == 'publicUser') {
          return UserHomeScreen();
        } else
          return standardLoadingScreen(
            message: 'Getting user data',
          );
      });
}
