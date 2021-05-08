import 'package:flutter/material.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
import 'package:pet_matcher/widgets/standard_input_box.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final firebaseAuth = fb_auth.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        leading: BackButton(),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
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

  //Free Clip Art Reference: https://wikiclipart.com/dog-paw-prints-clip-art_37264/
  Widget logo() {
    return Image.asset('assets/images/paw_logo.png',
        height: 175, width: 150, fit: BoxFit.fitWidth);
  }

  Widget titleText() {
    return Padding(
        padding: EdgeInsets.only(top: 5, bottom: 30, left: 10, right: 10),
        child: Text(
          'Pet Matcher',
          style: TextStyle(fontSize: 35, color: Colors.white),
        ));
  }

  Widget emailField(BuildContext context) {
    return standardInputBoxWithoutFlex(
      labelText: 'Email',
      validatorPrompt: 'Please enter your last name.',
      onSaved: (value) {},
      validatorCondition: (value) => value.isEmpty,
      controller: _emailController,
    );
  }

  Widget passwordField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'Password',
        validatorPrompt: 'Enter password',
        onSaved: (value) {},
        validatorCondition: (value) => value.isEmpty,
        controller: _passwordController,
        maxLines: 1,
        obscureText: true);
  }

  Widget loginButton(BuildContext context) {
    return addPadding(
      elevatedButtonStandard('Login', signIn),
    );
  }

  void signIn() async {
    if (formKey.currentState.validate()) {
      try {
        await locator<AppUserService>().signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );
        String userRole = await locator<AppUserService>().userRole;
        pushUserHomeScreen(context, userRole);
      } catch (e) {
        print(e);
      }
    }
  }

  Widget addPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }

  void pushUserHomeScreen(BuildContext context, String userRole) {
    if (userRole == 'publicUser') {
      Navigator.of(context).pushReplacementNamed(
        UserHomeScreen.routeName,
      );
    } else if (userRole == 'admin') {
      Navigator.of(context).pushReplacementNamed(AdminHomeScreen.routeName);
    }
  }

  void displaySnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
