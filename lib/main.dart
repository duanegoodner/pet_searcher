import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:pet_matcher/app.dart';
import 'package:pet_matcher/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(PetMatcherApp());
}
