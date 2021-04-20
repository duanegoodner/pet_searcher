import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/services/firebase_auth_service.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
import 'package:pet_matcher/widgets/standard_input_box.dart';

import 'login_screen.dart';

import '../services/new_app_user_dto.dart';

class AccountSetupScreen extends StatefulWidget {
  static const routeName = 'accountSetup';

  @override
  _AccountSetupScreenState createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  final formKey = GlobalKey<FormState>();
  bool adminChecked = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final newAppUserData = NewAppUserDTO();
  final firebaseAuth = FirebaseAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create New Account'),
        backgroundColor: Colors.blue[300],
      ),
      backgroundColor: Colors.blue[300],
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                logo(),
                SizedBox(height: 20),
                firstNameField(context),
                lastNameField(context),
                cityField(context),
                stateZipRow(context),
                emailField(context),
                passwordField(context),
                adminCheckbox(context),
                submitButton(context),
              ],
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

  Widget logo() {
    return Image.asset('assets/images/paw_logo.png',
        height: 175, width: 150, fit: BoxFit.fitWidth);
  }

  Widget firstNameField(BuildContext context) {
    return standardInputBoxWithoutFlex(
      labelText: 'First Name',
      validatorPrompt: 'Enter your first name.',
      onSaved: (value) {
        newAppUserData.firstName = value;
      },
      validatorCondition: (value) => value.isEmpty,
    );
  }

  Widget lastNameField(BuildContext context) {
    return standardInputBoxWithoutFlex(
      labelText: 'Last Name',
      validatorPrompt: 'Enter your last name.',
      onSaved: (value) {
        newAppUserData.lastName = value;
      },
      validatorCondition: (value) => value.isEmpty,
    );
  }

  Widget emailField(BuildContext context) {
    return standardInputBoxWithoutFlex(
      labelText: 'Email',
      validatorPrompt: 'Enter your email.',
      onSaved: (value) {},
      validatorCondition: (value) => value.isEmpty,
      controller: _emailController,
    );
  }

  Widget passwordField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'Password',
        validatorPrompt: 'Enter a valid password',
        onSaved: (value) {},
        validatorCondition: (value) => value.isEmpty,
        controller: _passwordController,
        obscureText: true);
  }

  Widget cityField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'City',
        validatorPrompt: 'Enter your city.',
        onSaved: (value) {
          newAppUserData.city = value;
        },
        validatorCondition: (value) => value.isEmpty);
  }

  Widget postalCodeField(BuildContext context) {
    return standardInputBoxWithoutFlex(
      labelText: 'Postal Code',
      keyboardType: TextInputType.number,
      onSaved: (value) {
        newAppUserData.zipCode = int.parse(value);
      },
      validatorCondition: (value) => value.isEmpty,
    );
  }

  Widget stateField(BuildContext context) {
    return standardInputBoxWithoutFlex(
      labelText: 'State',
      validatorPrompt: 'Enter your state.',
      onSaved: (value) {
        newAppUserData.state = value;
      },
      validatorCondition: (value) => value.isEmpty,
    );
  }

  Widget stateZipRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(flex: 1, child: stateField(context)),
        Flexible(flex: 1, child: postalCodeField(context))
      ],
    );
  }

  Widget adminCheckbox(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.white),
          child: Checkbox(
            value: adminChecked,
            onChanged: (bool value) {
              setState(() {
                adminChecked = value;
                if (adminChecked == false) {
                  newAppUserData.role = 'publicUser';
                } else {
                  newAppUserData.role = 'admin';
                }
              });
            },
          ),
        ),
        Text('I am a shelter admin',
            style: TextStyle(fontSize: 18, color: Colors.white)),
      ],
    );
  }

  Widget submitButton(BuildContext context) {
    return addPadding(
      elevatedButtonStandard('Submit', createUser),
    );
  }

  void createUser() async {
    if (formKey.currentState.validate()) {
      try {
        formKey.currentState.save();
        fb_auth.User newFirebaseUser = await firebaseAuth.createFirebaseUser(
            _emailController.text, _passwordController.text);
        newAppUserData.email = newFirebaseUser.email;
        final appUserService = AppUserService(firebaseUser: newFirebaseUser);
        await appUserService.uploadNewUser(newAppUserData, newFirebaseUser.uid);
        Navigator.of(context).pushNamed(LoginScreen.routeName);
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

  void displaySnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
