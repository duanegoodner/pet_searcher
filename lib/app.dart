import 'package:pet_matcher/navigation/routes.dart';
import 'package:pet_matcher/navigation/startup_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/services/animal_service.dart';
import 'package:pet_matcher/services/image_service.dart';
import 'package:pet_matcher/styles.dart';
import 'package:provider/provider.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/locator.dart';

class PetMatcherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider(
          create: (context) => locator<AppUserService>().appUserAuthStateChange,
        ),
        StreamProvider(
          create: (context) => locator<AnimalService>().animalStream(),
          catchError: (_, __) => [Animal.nullAnimal()],
        ),
      ],
      child: MaterialApp(
        title: 'Pet Matcher',
        theme: ThemeData(
          primarySwatch: Styles.appBarColor,
        ),
        routes: RouteNames.routes,
        initialRoute: StartUpScreenController.routeName,
      ),
    );
  }
}
