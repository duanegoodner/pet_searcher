import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:pet_matcher/screens/login_screen.dart';
import 'package:pet_matcher/services/app_user_service.dart';
import 'package:pet_matcher/services/new_app_user_dto.dart';
import 'package:pet_matcher/styles.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
import 'package:pet_matcher/widgets/standard_input_box.dart';

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
  final firebaseAuth = fb_auth.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Create New Account'),
        backgroundColor: Styles.appBarColor,
      ),
      backgroundColor: Styles.backgroundColor,
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
        maxLines: 1,
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
            style: Styles.subtitleTextWhite),
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
        fb_auth.UserCredential newUserCredential =
            await firebaseAuth.createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        fb_auth.User newFirebaseUser = newUserCredential.user;
        newAppUserData.email = newFirebaseUser.email;
        final appUserService = AppUserService(firebaseAuth: firebaseAuth);
        await appUserService.uploadNewUser(newAppUserData, newFirebaseUser.uid);
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
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
