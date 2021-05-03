import 'package:flutter/material.dart';

Widget standardLoadingScreen({String message}) {
  return Scaffold(
    backgroundColor: Colors.blue[300],
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
