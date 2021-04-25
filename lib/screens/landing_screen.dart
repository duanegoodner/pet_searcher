import 'package:flutter/material.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';

import 'package:pet_matcher/screens/login_screen.dart';
import 'package:pet_matcher/screens/account_setup_screen.dart';

class LandingScreen extends StatelessWidget {
  static const routeName = 'landingScreen';

  final String title = 'Pet Matcher';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            titleText(),
            logo(),
            loginButton(context),
            createAccountLink(context),
          ],
        ),
      ),
    );
  }

  Widget titleText() {
    return Flexible(
        flex: 1,
        child: addPadding(
            Text(title, style: TextStyle(fontSize: 50, color: Colors.white))));
  }

  //Free Clip Art Reference: https://wikiclipart.com/dog-paw-prints-clip-art_37264/
  Widget logo() {
    return Flexible(
      flex: 2,
      child: addPadding(Image.asset('assets/images/paw_logo.png')),
    );
  }

  Widget loginButton(BuildContext context) {
    return Flexible(
      flex: 1,
      child: addPadding(
        elevatedButtonStandard('Log in',
            (() => {Navigator.of(context).pushNamed(LoginScreen.routeName)})),
      ),
    );
  }

  Widget createAccountLink(BuildContext context) {
    return Flexible(
      flex: 1,
      child: addPadding(GestureDetector(
        onTap: () {
          print('Create account tapped');
          Navigator.of(context).pushNamed(AccountSetupScreen.routeName);
        },
        child: Text('Create Account',
            style: TextStyle(fontSize: 18, color: Colors.white)),
      )),
    );
  }

  Widget addPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}
