import 'package:flutter/material.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //TO_DO: need to create a model class for user login credentials
  //final loginCredentials = loginCredentials();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logo(),
            titleText(),
            SizedBox(height: 20),
            emailField(context),
            passwordField(context),
            loginButton(context),
          ],
        ),
      ),
    );
  }

  //TO_DO: put logo in an assets file
  //Free Clip Art Reference: https://wikiclipart.com/dog-paw-prints-clip-art_37264/
  Widget logo() {
    return Flexible(
      flex: 1,
      child: addPadding(Image.network(
          'https://wikiclipart.com/wp-content/uploads/2017/11/Dog-paw-prints-panther-paw-print-clip-art-clipart-locker.png')),
    );
  }

  Widget titleText() {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: EdgeInsets.only(top: 5, bottom: 30, left: 10, right: 10),
        child: Text(
          'Pet Matcher',
          style: TextStyle(
            fontSize: 35, 
            color: Colors.white
          )
        )
      )
    );
  }

  Widget emailField(BuildContext context) {
    return Flexible(
      flex: 2,
      child: addPadding(
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(40.0)
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.email_outlined),
                border: InputBorder.none,
                labelText: 'EMAIL',
              ),
              onSaved: (value) {
                //loginCredentials.email = value;
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your email.';
                } else {
                  return null; //validation passed
                }
              }
            )
          )
        )
      ),
    );
  }

  Widget passwordField(BuildContext context) {
    return Flexible(
      flex: 2,
      child: addPadding(
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(40.0)
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: TextFormField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outlined),
                border: InputBorder.none,
                labelText: 'PASSWORD',
              ),
              onSaved: (value) {
                //loginCredentials.password = value;
              },
              obscureText: true, //obscure text because a password
              validator: (value) {
                //TO_DO: add validation for checking password length, etc.
                if (value.isEmpty) {
                   return 'Please enter password.';
                } else {
                   return null; //validation passed
                }
              }
            )
          )
        )
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return Flexible(
      flex: 1,
      child: addPadding(
        elevatedButtonStandard(
          'Login',
          (() => {
            //TO_DO: query db, locate user data, check valid user, 
            //navigate to new screen
            print('Querying the database. Navigating to animal filter page.')
          })
        ),
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
