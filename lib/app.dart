import 'package:pet_matcher/screens/user_home_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:flutter/material.dart';

import 'screens/admin_home_screen.dart';
import 'screens/user_home_screen.dart';
import 'screens/landing_screen.dart';

import 'navigation/routes.dart';

import 'widgets/service_providers/firebase_service_providers.dart';
import 'widgets/service_providers/app_user_service_provider.dart';
import 'widgets/standard_loading_screen.dart';

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
          // initialRoute: LandingScreen.routeName,
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
          return FutureBuilder(
              future: Provider.of<AppUserService>(context).isUserAdmin,
              builder: (context, snapshot) {
                if (snapshot.data == 'admin') {
                  return AdminHomeScreen();
                } else if (snapshot.data == 'publicUser') {
                  return UserHomeScreen();
                } else
                  return StandardLoadingScreen(
                    message: 'Getting user data',
                  );
              });
        } else {
          return StandardLoadingScreen(
            message: 'Waiting for Firebase',
          );
        }
      },
    );
  }
}
