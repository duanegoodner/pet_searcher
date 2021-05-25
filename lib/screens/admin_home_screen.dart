import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/screens/add_news_item_screen.dart';
import 'package:pet_matcher/screens/animal_inventory_screen.dart';
import 'package:pet_matcher/screens/choose_animal_type_screen.dart';
import 'package:pet_matcher/screens/news_screen.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/background_image.dart';
import 'package:pet_matcher/widgets/standard_tile.dart';
import 'package:provider/provider.dart';

import '../styles.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routeName = 'adminHome';

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    String userName = Provider.of<AppUser>(context).firstName.toUpperCase();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Pet Matcher'),
        backgroundColor: Styles.appBarColor,
      ),
      drawer: AdminDrawer(),
      body: Stack(
        children: [
          backgroundImage('assets/images/dog_shaking_hands.jpg'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              welcomeText(userName),
              gridView(),
            ],
          )
        ],
      ),
    );
  }

  Widget welcomeText(String userName) {
    return Padding(
      padding: EdgeInsets.only(top: 60, left: 20, bottom: 40),
      child: Text(
        'WELCOME $userName',
        style: Styles.titleTextBlack
      ),
    );
  }

  Widget gridView() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.all(10),
        children: [
          standardTile(
            icon: Icons.rss_feed, 
            text: 'News Feed', 
            routeToNewScreen: () {
              Navigator.of(context).pushReplacementNamed(NewsScreen.routeName);
            }
          ),
          standardTile(
            icon: FontAwesomeIcons.newspaper, 
            text: 'Add News Post', 
            routeToNewScreen: () {
              Navigator.of(context).pushNamed(AddNewsItemScreen.routeName);
            }
          ),
          standardTile(
            icon: FontAwesomeIcons.paw, 
            text: 'Inventory', 
            routeToNewScreen: () {
              Navigator.of(context)
                .pushReplacementNamed(AnimalInventoryScreen.routeName);
            }
          ),
          standardTile(
            icon: FontAwesomeIcons.dog, 
            text: 'Add New Animal', 
            routeToNewScreen: () {
              Navigator.of(context).pushNamed(ChooseAnimalTypeScreen.routeName);
            }
          ),
        ],
      ),
    );
  }

}
