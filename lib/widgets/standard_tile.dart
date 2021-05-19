import 'package:flutter/material.dart';

Widget standardTile({
  @required var icon, 
  @required String text, 
  @required Function routeToNewScreen
}) {
  return GestureDetector(
    child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
          color: Colors.blue.withOpacity(.80),
        ),
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Icon(icon, size: 75, color: Colors.white),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                '$text',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            )
          ],
        )),
    onTap: routeToNewScreen,
  );
}
