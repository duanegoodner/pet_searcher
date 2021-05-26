import 'package:flutter/material.dart';
import 'package:pet_matcher/screens/favorite_screen.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/screens/news_screen.dart';
import 'package:pet_matcher/widgets/background_image.dart';
import 'package:pet_matcher/widgets/standard_tile.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/screens/animal_inventory_screen.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<AppUser>(context).firstName.toUpperCase();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pet Matcher'),
        backgroundColor: Styles.appBarColor,
      ),
      drawer: UserDrawer(),
      body: Stack(
        children: [
          backgroundImage('assets/images/dog_shaking_hands.jpg'),
          welcomeText(userName),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [gridView()],
          ),
        ],
      ),
    );
  }

  Widget welcomeText(String userName) {
    return Padding(
      padding: EdgeInsets.only(top: 60, left: 225, bottom: 40),
      child: Text(
        'WELCOME $userName',
        style: Styles.titleTextBlack,
      ),
    );
  }

  Widget gridView() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.only(left: 5, right: 190),
      child: GridView.count(
        crossAxisCount: 1,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        children: [
          standardTile(
              icon: Icons.rss_feed,
              text: 'News Feed',
              routeToNewScreen: () {
                Navigator.of(context)
                    .pushReplacementNamed(NewsScreen.routeName);
              }),
          standardTile(
              icon: FontAwesomeIcons.paw,
              text: 'Search Animals',
              routeToNewScreen: () {
                Navigator.of(context)
                    .pushReplacementNamed(AnimalInventoryScreen.routeName);
              }),
          standardTile(
              icon: Icons.favorite,
              text: 'Favorites',
              routeToNewScreen: () {
                //NOTE: need to change to favorites screen once it is created
                Navigator.of(context).pushNamed(FavoriteScreen.routeName);
              }),
        ],
      ),
    ));
  }
}
