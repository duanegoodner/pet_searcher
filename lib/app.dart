import 'package:pet_matcher/screens/add_pet_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';

import 'package:pet_matcher/screens/landing_screen.dart';

import 'package:pet_matcher/navigation/routes.dart';

import 'package:pet_matcher/widgets/firebase_service_providers.dart';
import 'package:pet_matcher/widgets/app_user_service_provider.dart';
import 'package:pet_matcher/widgets/standard_loading_screen.dart';
import 'package:pet_matcher/widgets/user_homescreen_selector.dart';

class PetMatcherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirebaseServiceProviders(
      child: AppUserServiceProvider(
        child: MaterialApp(
          title: 'Pet Matcher',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: StartupScreenSelector(),
          routes: RouteNames.routes,
          // initialRoute: AddPetScreen.routeName,
        ),
      ),
    );
  }
}

class StartupScreenSelector extends StatelessWidget {
  const StartupScreenSelector({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<fb_auth.FirebaseAuth>(context).authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return LandingScreen();
          }
          return userHomeScreenSelector(context);
        } else {
          return standardLoadingScreen(
            message: 'Waiting for Firebase',
          );
        }
      },
    );
  }
}
