import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:pet_matcher/screens/user_home_screen.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';

import '../models/app_user.dart';
import '../services/firebase_auth_service.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firebaseAuth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: Center(
        child: Form(
          key: formKey,
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
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
          style: TextStyle(fontSize: 35, color: Colors.white),
        ),
      ),
    );
  }

  Widget emailField(BuildContext context) {
    return Flexible(
      flex: 2,
      child: addPadding(
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(40.0)),
          child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5),
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                icon: Icon(Icons.email_outlined),
                border: InputBorder.none,
                labelText: 'EMAIL',
              ),
              // onSaved: (value) {
              //   //loginCredentials.email = value;
              // },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your email.';
                } else {
                  return null; //validation passed
                }
              },
            ),
          ),
        ),
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
              borderRadius: new BorderRadius.circular(40.0)),
          child: Padding(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 5,
            ),
            child: TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                icon: Icon(Icons.lock_outlined),
                border: InputBorder.none,
                labelText: 'PASSWORD',
              ),
              // onSaved: (value) {
              //   //loginCredentials.password = value;
              // },
              obscureText: true, //obscure text because a password
              validator: (value) {
                //TO_DO: add validation for checking password length, etc.
                if (value.isEmpty) {
                  return 'Please enter password.';
                } else {
                  return null; //validation passed
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(BuildContext context) {
    return Flexible(
      flex: 1,
      child: addPadding(
        elevatedButtonStandard('Login', signIn),
      ),
    );
  }

  void signIn() async {
    if (formKey.currentState.validate()) {
      try {
        fb_auth.User user = await _firebaseAuth.firebaseSignIn(
          _emailController.text,
          _passwordController.text,
        );
        AppUser _appUser = await _firebaseAuth.getAppUser(user);
        pushUserHomeScreen(context, _appUser);
      } catch (e) {
        print(e);
      }
    }
  }

  void pushUserHomeScreen(BuildContext context, AppUser appUser) {
    Navigator.of(context).pushNamed(
      UserHomeScreen.routeName,
      arguments: appUser,
    );
  }

  Widget addPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}
