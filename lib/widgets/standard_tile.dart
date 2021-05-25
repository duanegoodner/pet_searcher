import 'package:flutter/material.dart';

import '../styles.dart';

Widget standardTile({
  @required var icon, 
  @required String text, 
  @required Function routeToNewScreen
}) {
  return GestureDetector(
    child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          color: Styles.tileColor,
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
              child: Icon(icon, size: 75, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '$text',
                style: Styles.subtitleTextWhiteBold, 
              ),
            )
          ],
        )),
    onTap: routeToNewScreen,
  );
}
