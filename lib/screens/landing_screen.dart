import 'package:flutter/material.dart';
import 'package:pet_searcher/widgets/elevated_button.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key key, this.title}) : super(key: key);

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
            loginButton(),
            createAccountLink(),
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
      child: addPadding(Image.network(
          'https://wikiclipart.com/wp-content/uploads/2017/11/Dog-paw-prints-panther-paw-print-clip-art-clipart-locker.png')),
    );
  }

  Widget loginButton() {
    return Flexible(
      flex: 1,
      child: addPadding(elevatedButtonStandard('Log in', 'log_in_screen')),
    );
  }

  Widget createAccountLink() {
    return Flexible(
      flex: 1,
      child: addPadding(
        GestureDetector(
          onTap: () {
            print('Create account tapped');
            //need to add routing to create account form screen
          },
          child: Text(
            'Create Account',
            style: TextStyle(
              fontSize: 18, 
              color: Colors.white
            )
          ),
        )
      ),
    );
  }

  Widget addPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}
