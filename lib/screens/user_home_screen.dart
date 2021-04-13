import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';

  UserHomeScreen({Key key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final String userEmail = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        leading: BackButton(),
        title: Text(userEmail),
      ),
    );
  }
}
