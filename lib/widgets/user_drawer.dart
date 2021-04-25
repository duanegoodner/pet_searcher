import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/screens/add_pet_screen.dart';
import 'package:provider/provider.dart';
import 'package:pet_matcher/screens/user_home_screen_UI.dart';
import 'package:pet_matcher/screens/landing_screen.dart';
import '../models/app_user.dart';

class UserDrawer extends StatelessWidget {
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
              padding:
              EdgeInsets.only(top: 50, left: 15, right: 20, bottom: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                'Menu',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 10),
            buildListTile(
              title: 'Home',
              icon: Icons.home,
              onTap: () {
                pushUserHome(context);
              },
            ),
            buildListTile(
              title: 'Search Animals',
              icon: FontAwesomeIcons.paw,
              onTap: () {
                pushUserHome(context);
              },
            ),
            buildListTile(
              title: 'Featured Animals',
              icon: FontAwesomeIcons.dog,
              onTap: () {
                pushUserHome(context);
              },
            ),
            buildListTile(
              title: 'View Favorites',
              icon: Icons.favorite,
              onTap: () {
                //pushFavoritesScreen(context);
              },
            ),
            buildListTile(
              title: 'Log Out',
              icon: Icons.logout,
              onTap: () {
                logout(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildListTile({String title, IconData icon, Function onTap}) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: onTap,
    );
  }

  void pushUserHome(BuildContext context) {
    Navigator.of(context).pushNamed(UserHomeScreen.routeName);
  }

  /*void pushFavoritesScreen(BuildContext context) {
    Navigator.of(context).pushNamed(FavoritePets.routeName);
  }*/

  void logout(BuildContext context) async {
    await Provider.of<fb_auth.FirebaseAuth>(context, listen: false).signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
  }
}