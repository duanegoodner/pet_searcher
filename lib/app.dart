import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';

class PetSearcherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Matcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pet Matcher'),
    );
  }
}

