import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/screens/animal_inventory_screen.dart';
import 'package:pet_matcher/screens/news_screen.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';
import 'package:pet_matcher/screens/landing_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import '../styles.dart';

class UserDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Styles.backgroundColor,
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
                style: Styles.drawerHeadingText,
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
                pushSearchAnimals(context);
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
        style: Styles.drawerListText,
      ),
      onTap: onTap,
    );
  }

  void pushUserHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(UserHomeScreen.routeName);
  }

  void pushSearchAnimals(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AnimalInventoryScreen.routeName);
  }

  void pushNewsScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(NewsScreen.routeName);
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
