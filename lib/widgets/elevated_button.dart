import 'package:flutter/material.dart';

Widget elevatedButtonStandard(String buttonText, String navigationRoute) {
  return ElevatedButton(
    onPressed: () {
      print('Navigating to $navigationRoute');
      //add navigation push
    },
    child: Padding(
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
      child: Text('Log in'),
    ),
    style: ElevatedButton.styleFrom(
      primary: Colors.grey,
      onPrimary: Colors.white,
      textStyle: TextStyle(color: Colors.white, fontSize: 28),
      shadowColor: Colors.black,
      elevation: 8,
    ),
  );
}
