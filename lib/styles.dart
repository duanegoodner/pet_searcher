import 'package:flutter/material.dart';

class Styles {
  static Color backgroundColor = Colors.blue[300];
  static Color appBarColor = Colors.blue;
  static Color tileColor = Colors.blue.withOpacity(.80);
  static Color popUpColor = Colors.blue[200];

  static final animalDetailHeadingText = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final animalDetailDatingBlurbText = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static final drawerHeadingText = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final drawerListText = TextStyle(color: Colors.white);

  static final dispositionHeader = TextStyle(
    color: Colors.white,
    fontSize: 24,
  );

  static final elevatedButtonText =
      TextStyle(color: Colors.white, fontSize: 28);

  static final fabText = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final dispositionHeaderWhite = TextStyle(
    color: Colors.white,
    fontSize: 20,
  );

  //used on multiple screens, check all references before changing
  static final detailTextBlack = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 14,
  );

  static final dropdownText = TextStyle(
    fontSize: 13,
  );

  static final inventoryDateText = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 13,
  );

  static final landingPageTitleText =
      TextStyle(fontSize: 50, color: Colors.white);

  static final loginTitleText = TextStyle(fontSize: 35, color: Colors.white);

  static final multiSelectChipSelectedText =
      TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold);

  static final multiSelectChipText =
      TextStyle(color: Colors.grey[700], fontSize: 13);

  static final newsFeedTitleText = TextStyle(
    fontSize: 26,
  );

  static final newsFeedBodyText = TextStyle(
    fontSize: 16,
  );

  static final newsFeedDateText = TextStyle(fontWeight: FontWeight.bold);

  static final standardTextWhite = TextStyle(
    color: Colors.white,
  );

  //used on multiple screens, check all references before changing
  static final subtitleTextWhite = TextStyle(fontSize: 18, color: Colors.white);

  //used on multiple screens, check all references before changing
  static final subtitleTextWhiteBold = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  //used on multiple screens, check all references before changing
  static final titleTextBlack = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );
}
