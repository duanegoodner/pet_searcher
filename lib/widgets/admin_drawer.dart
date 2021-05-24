import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/screens/animal_inventory_screen.dart';
import 'package:pet_matcher/screens/choose_animal_type_screen.dart';
import 'package:pet_matcher/screens/news_screen.dart';
import 'package:pet_matcher/services/animal_service.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/screens/landing_screen.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/styles.dart';

class AdminDrawer extends StatelessWidget {
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
                pushAdminHome(context);
              },
            ),
            buildListTile(
              title: 'News Feed',
              icon: Icons.rss_feed,
              onTap: () {
                pushNewsScreen(context);
              },
            ),
            buildListTile(
              title: 'Inventory',
              icon: FontAwesomeIcons.paw,
              onTap: () {
                pushAnimalInventoryScreen(context);
              },
            ),
            buildListTile(
              title: 'Featured Animals',
              icon: FontAwesomeIcons.dog,
              onTap: () {
                pushAdminHome(context);
              },
            ),
            buildListTile(
              title: 'Add New Animal',
              icon: FontAwesomeIcons.star,
              onTap: () {
                pushChooseAnimalTypeScreen(context);
              },
            ),
            buildListTile(
                title: 'Reset Animal Options',
                icon: FontAwesomeIcons.database,
                onTap: () {
                  resetAnimalAttributes(context);
                }),
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

  void pushAdminHome(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AdminHomeScreen.routeName);
  }

  void pushNewsScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(NewsScreen.routeName);
  }

  void pushAnimalInventoryScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(AnimalInventoryScreen.routeName);
  }

  void pushChooseAnimalTypeScreen(BuildContext context) {
    Navigator.of(context)
        .pushReplacementNamed(ChooseAnimalTypeScreen.routeName);
  }

  void resetAnimalAttributes(BuildContext context) async {
    locator<AnimalService>().resetAttributes();
  }

  void logout(BuildContext context) async {
    await locator<AppUserService>().firebaseAuth.signOut();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
  }
}
