import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';
import 'dart:convert';


class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHome';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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
        title: Text('Find a Match!'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: UserDrawer(),
      backgroundColor: Colors.blue[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            animalSearch(),
            headingText('View Favorites:'),
            favoritesCard(),
            headingText('Featured Animals:'),
            featuredAnimals(),
            headingText('News Feed:'),
            Center(
              child: newsCard(),
            ),
          ],
        ),
      ),
    );
  }

  Widget headingText(String heading) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Text('${heading}',
        style: TextStyle(
          fontSize: 26,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget animalSearch() {
    return GestureDetector(
      onTap: () {
        //Go to search screen
        print('Going to search!');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: iconRow(),
      ),
    );
  }

  Widget iconRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Search',
              style: TextStyle(
                  color: Colors.blue[300],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0
              )),
          Icon(FontAwesomeIcons.dog,
              color: Colors.blue[300],
              size: 35
          ),
          Icon(FontAwesomeIcons.cat,
              color: Colors.blue[300],
              size: 35
          ),
          Icon(FontAwesomeIcons.featherAlt,
              color: Colors.blue[300],
              size: 35
          ),
        ]
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
              title: Text('${heading}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              subtitle: Text('${body}',
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

  Widget favoritesCard() {
    return Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          width: 275,
          height: 218,
          child: Card(
                color: Colors.white,
                elevation: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      children: <Widget> [
                        Card(
                        child: Wrap(
                          children: <Widget>[
                            Image.asset('assets/images/frenchie_in_costume.jpg',
                                height: 200, width: 275, fit: BoxFit.fitWidth),
                            ]
                          )
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0, left: 238.0),
                        child: Icon(Icons.favorite,
                        color: Colors.red),
                      ),
                      ]
                    ),
                   ]
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
                child: Wrap(
                    children: <Widget>[
                      Image.asset('assets/images/puppy.jpg',
                          height: 165, width: 275, fit: BoxFit.fitHeight),
                    ]
                )
            ),
            Row(
              children: <Widget>[
                animalCardText('Rufus', 16.0)
              ],
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
      child: Text('${animalText}',
          style: TextStyle(
              fontSize: size
          )),
    );
  }
}