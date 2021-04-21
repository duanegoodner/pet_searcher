import 'package:flutter/material.dart';

Widget standardLoadingScreen({String message}) {
  return Scaffold(
    backgroundColor: Colors.blue[300],
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
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
