import 'package:flutter/material.dart';

import '../styles.dart';

Widget standardLoadingScreen({String message}) {
  return Scaffold(
    backgroundColor: Styles.backgroundColor,
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
