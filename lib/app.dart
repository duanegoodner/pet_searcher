import 'package:pet_matcher/screens/user_home_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'screens/test_screen.dart';
import 'navigation/routes.dart';

class PetMatcherApp extends StatelessWidget {
  // final Future<FirebaseApp> _initializeFirebase = Firebase.initializeApp();

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

class DummyApp extends StatelessWidget {
  final Future<FirebaseApp> _initializeFirebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase,
      builder: (context, snapshot) {
        return FirebaseServiceProviders(
          child: AppUserServiceProvider(
            child: MaterialApp(
              title: 'Pet Matcher',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}

class FirebaseServiceProviders extends StatelessWidget {
  final Widget child;

  const FirebaseServiceProviders({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      Provider(
        create: (_) => fb_auth.FirebaseAuth.instance,
      ),
      Provider(
        create: (_) => cf.FirebaseFirestore.instance,
      ),
    ], child: child);
  }
}

class AppUserServiceProvider extends StatelessWidget {
  final Widget child;

  const AppUserServiceProvider({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseAuth = Provider.of<fb_auth.FirebaseAuth>(context);
    return Provider(
      create: (context) => AppUserService(firebaseAuth: firebaseAuth),
      child: child,
    );
  }
}

class ExistingLoginChecker extends StatelessWidget {
  const ExistingLoginChecker({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<fb_auth.FirebaseAuth>(context).authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data == null) {
            return LandingScreen();
          }
          // change to user role checker
          return UserHomeScreen();
        } else {
          return Scaffold(
            backgroundColor: Colors.blue[300],
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Wating for Firebase Connection',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
      },
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
          return UserHomeScreen();
        } else {
          return Scaffold(
            backgroundColor: Colors.blue[300],
            body: Center(
              child: Column(
                children: [
                  Text(
                    'Wating for Firebase Connection',
                    style: TextStyle(
                      fontSize: 50,
                      color: Colors.white,
                    ),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
