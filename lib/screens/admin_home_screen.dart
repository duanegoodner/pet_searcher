import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pet_matcher/widgets/admin_drawer.dart';

class AdminHomeScreen extends StatelessWidget {

  static const routeName = 'adminHome';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Text('Admin'),
    backgroundColor: Colors.blue[300],
    ),
    drawer: AdminDrawer(),
    backgroundColor: Colors.blue[300],
    body: Center(
      child: Text('Admin Page',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
     )
   );
  }

}