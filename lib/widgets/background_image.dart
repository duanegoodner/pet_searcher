import 'package:flutter/material.dart';

Widget backgroundImage(String imageFilePath) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('$imageFilePath'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }