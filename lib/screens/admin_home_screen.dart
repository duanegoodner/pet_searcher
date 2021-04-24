import 'package:flutter/material.dart';
//import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:flutter/services.dart';
//import 'dart:convert';
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
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 30,
                decoration: BoxDecoration(color: Colors.blue[300])
              ),
              recentNewsItemListTile(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget recentNewsItemListTile(BuildContext context) {
    return ListTile(
      title: Text(
        '$heading',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 26,
        ),
      ),
      subtitle: Column(
        children: [
          Text('$body',textAlign: TextAlign.center, style: TextStyle(
            fontSize: 16,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            ),
          ],
        )],
      ), 
    );
  }

}
