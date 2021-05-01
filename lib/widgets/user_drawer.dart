import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/screens/news_screen.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';
import 'package:pet_matcher/screens/landing_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';

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
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue[700]),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset('assets/images/paw_logo.png'),
                  ),
                  Container(
                    padding:
                    EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 10),
                    child: Text(
                      'Menu',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ]
              ),
            ),
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
                title: 'News Feed',
                icon: Icons.rss_feed,
                onTap: () {
                  pushNewsScreen(context);
                }),
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

  void pushNewsScreen(BuildContext context) {
    Navigator.of(context).pushNamed(NewsScreen.routeName, arguments: 'user');
  }

  /*void pushFavoritesScreen(BuildContext context) {
    Navigator.of(context).pushNamed(FavoritePets.routeName);
  }*/

  void logout(BuildContext context) async {
    await locator<AppUserService>().firebaseAuth.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
  }
}
