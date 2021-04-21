import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';

import 'package:pet_matcher/widgets/admin_drawer.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routeName = 'adminHome';

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  //Map<String, dynamic> newsData;
  final String heading = "Happy National Pet Day!";
  final String body = "Show us your best pictures of your furry friends!\n"
      "Don't currently have a fluffy friend to love?\n"
      "Browse through our available pets and arrange\n "
      "a date today!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Admin'),
          backgroundColor: Colors.blue[300],
        ),
        drawer: AdminDrawer(),
        backgroundColor: Colors.blue[300],
        body: Center(
          child: Container(
            height: 275,
            width: 275,
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Newsfeed:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                        onPressed: () {
                          //Popup form???
                        }),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${heading}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '${body}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
