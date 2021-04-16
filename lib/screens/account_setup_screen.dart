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
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    stateField(context),
                    postalCodeField(context),
                  ],
                ),
              ),
              emailField(context),
              passwordField(context),
              //stateField(context),
              //postalCodeField(context),
              submitButton(context),
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

  Widget logo() {
    return Flexible(
      flex: 2,
      child: addPadding(Image.network(
          'https://wikiclipart.com/wp-content/uploads/2017/11/Dog-paw-prints-panther-paw-print-clip-art-clipart-locker.png')),
    );
  }

  Widget firstNameField(BuildContext context) {
    return standardInputBox(
      labelText: 'First Name',
      validatorPrompt: 'Please enter your first name.',
      flexVal: 1,
      onSaved: (value) {
        newAppUserData.firstName = value;
      },
      validatorCondition: (value) => value.isEmpty,
    );
  }

  Widget lastNameField(BuildContext context) {
    return standardInputBox(
      labelText: 'Last Name',
      validatorPrompt: 'Please enter your last name.',
      flexVal: 1,
      onSaved: (value) {
        newAppUserData.lastName = value;
      },
      validatorCondition: (value) => value.isEmpty,
    );
  }

  Widget emailField(BuildContext context) {
    return standardInputBox(
      labelText: 'Email',
      validatorPrompt: 'Please enter your email.',
      flexVal: 1,
      onSaved: (value) {},
      validatorCondition: (value) => value.isEmpty,
      controller: _emailController,
    );
  }

  Widget passwordField(BuildContext context) {
    return standardInputBox(
        labelText: 'Password',
        validatorPrompt: 'Please enter a valid password',
        flexVal: 1,
        onSaved: (value) {},
        validatorCondition: (value) => value.isEmpty,
        controller: _passwordController,
        obscureText: true);
  }

  Widget cityField(BuildContext context) {
    return standardInputBox(
        labelText: 'Enter City',
        validatorPrompt: 'Please enter your city.',
        flexVal: 1,
        onSaved: (value) {
          newAppUserData.city = value;
        },
        validatorCondition: (value) => value.isEmpty);
  }

  Widget postalCodeField(BuildContext context) {
    return standardInputBox(
      labelText: 'Enter Postal Code',
      flexVal: 1,
      keyboardType: TextInputType.number,
      onSaved: (value) {
        newAppUserData.zipCode = int.parse(value);
      },
      validatorCondition: (value) => value.isEmpty,
    );
  }

  Widget stateField(BuildContext context) {
    return standardInputBox(
      labelText: 'Enter State',
      validatorPrompt: 'Please enter your state.',
      flexVal: 1,
      onSaved: (value) {
        newAppUserData.state = value;
      },
      validatorCondition: (value) => value.isEmpty,
    );
  }

  Widget submitButton(BuildContext context) {
    return Flexible(
      flex: 1,
      child: addPadding(
        elevatedButtonStandard('Submit', createUser),
      ),
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
