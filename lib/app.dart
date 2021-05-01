import 'package:pet_matcher/navigation/routes.dart';
import 'package:pet_matcher/navigation/startup_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:pet_matcher/screens/news_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/locator.dart';

class PetMatcherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => locator<AppUserService>().appUserAuthStateChange,
      child: MaterialApp(
        title: 'Pet Matcher',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: startupScreenSelector(context),
        //home: NewsScreen(),
        routes: RouteNames.routes,
        initialRoute: StartUpScreenController.routeName,
      ),
    );
  }
}
