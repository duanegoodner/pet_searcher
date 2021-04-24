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
  final String body = "Show us your best pictures of your furry friends! "
      "Don't currently have a fluffy friend to love? "
      "Browse through our available pets and arrange "
      "a date today!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin'),
        backgroundColor: Colors.blue[300],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            headingText('News Feed:'),
            Center(
              child: newsCard(),
            ),
            headingText('Manage Inventory:'),
            inventoryCard(),
            headingText('Featured Animals:'),
            featuredAnimals(),
          ],
        ),
      ),
    );
  }

  Widget headingText(String heading) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Text(
        '${heading}',
        style: TextStyle(
          fontSize: 26,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget newsCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 275,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                '${heading}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              subtitle: Text(
                '${body}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    //Do we want a popup window? New page?
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget inventoryCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 275,
      height: 265,
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
                child: Wrap(children: <Widget>[
              Image.asset('assets/images/frenchie_in_costume.jpg',
                  height: 200, width: 275, fit: BoxFit.fitWidth),
            ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    //Animal inventory page?
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget featuredAnimals() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 285,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          featuredAnimalCard(),
          featuredAnimalCard(),
          featuredAnimalCard(),
        ],
      ),
    );
  }

  Widget featuredAnimalCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 160,
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
                child: Wrap(children: <Widget>[
              Image.asset('assets/images/puppy.jpg',
                  height: 165, width: 275, fit: BoxFit.fitHeight),
            ])),
            Row(
              children: <Widget>[],
            ),
            Row(
              children: <Widget>[
                animalCardText('Adult male', 14.0),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      //Animal inventory page?
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget animalCardText(String animalText, double size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('${animalText}', style: TextStyle(fontSize: size)),
    );
  }
}
