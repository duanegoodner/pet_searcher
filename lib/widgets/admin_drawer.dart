import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/screens/landing_screen.dart';
import '../models/app_user.dart';


class AdminDrawer extends StatelessWidget {

  //Refactor code; create 2 listTile functions

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[300],
          ),
          child: Column(
            children: <Widget>[
              Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.only(top: 50, left: 15, right: 20, bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text('Menu',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10),
                ListTile(
                  leading: Icon(Icons.home,
                  color: Colors.white,
                  size: 20,
                  ),
                  title: Text('Home',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(AdminHomeScreen.routeName);
                  },
                ),
                ListTile(
                    leading: Icon(Icons.rss_feed,
                      color: Colors.white,
                      size: 20,
                    ),
                    title: Text('News Feed',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      //Navigate to news feed update page?
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.paw,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text('Inventory',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    //Navigate to inventory page
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.dog,
                    color: Colors.white,
                    size: 20,
                  ),
                  title: Text('Featured Animals',
                    style: TextStyle(color: Colors.white),
                    ),
                  onTap: () {
                    //Navigate to featured animal page?
                  },
                ),
              ListTile(
                leading: Icon(Icons.logout,
                  color: Colors.white,
                  size: 25,
                ),
                title: Text('Log Out',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  //Log out of app
                },
              ),
            ],
          ),
        ),
    );
  }



  /*void _logout() async {
    await _firebaseAuth.firebaseSignOut();
    Navigator.popUntil(
      context,
      ModalRoute.withName(LandingScreen.routeName),
    );
  }*/
}