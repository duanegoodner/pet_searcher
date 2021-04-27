import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/services/animal_service.dart';
import 'package:pet_matcher/services/app_user_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(
      () => AppUserService(firebaseAuth: FirebaseAuth.instance));
  locator.registerLazySingleton(() => AnimalService());

  locator.registerFactory(() => AppUser());
  locator.registerFactory(() => Animal());
}
