import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/screens/landing_screen.dart';
import '../models/app_user.dart';


class AdminDrawer extends StatelessWidget {


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
                buildListTile(context, 'Home', Icons.home),
                buildListTile(context, 'News Feed', Icons.rss_feed),
                buildListTile(context, 'Inventory', FontAwesomeIcons.paw),
                buildListTile(context, 'Featured Animals', FontAwesomeIcons.dog),
                buildListTile(context, 'Log Out', Icons.logout),
            ],
          ),
        ),
    );
  }

  Widget buildListTile(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon,
        color: Colors.white,
        size: 20,
      ),
      title: Text(title,
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.of(context).pushNamed(AdminHomeScreen.routeName);
      },
    );
  }

}