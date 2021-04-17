import 'package:flutter/material.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';

import 'login_screen.dart';
import 'package:pet_matcher/models/app_user.dart';

class AccountSetupScreen extends StatefulWidget {
  static const routeName = 'accountSetup';

  @override
  _AccountSetupScreenState createState() => _AccountSetupScreenState();
}

class _AccountSetupScreenState extends State<AccountSetupScreen> {
  final formKey = GlobalKey<FormState>();
  bool adminChecked = false;
  final newUser = AppUser();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logo(),
            SizedBox(height: 20),
            firstNameField(context),
            lastNameField(context),
            emailField(context),
            cityField(context),
            stateZipRow(context),
            adminCheckbox(context),
            submitButton(context),
          ],
        ),
      ),
    );
  }

  Widget logo() {
    return Flexible(
      flex: 2,
      child: addPadding(Image.asset('assets/images/paw_logo.png'))
      );
  }

  Widget firstNameField(BuildContext context) {
    return Flexible(
      flex: 1,
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
                        border: InputBorder.none,
                        labelText: 'First Name',
                      ),
                      onSaved: (value) {
                        //newUser.firstName = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your first name.';
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

  Widget lastNameField(BuildContext context) {
    return Flexible(
      flex: 1,
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
                        border: InputBorder.none,
                        labelText: 'Last Name',
                      ),
                      onSaved: (value) {
                        //newUser.lastName = value;
                      },
                      validator: (value) {
                        //TO_DO: add validation for checking password length, etc.
                        if (value.isEmpty) {
                          return 'Please enter your last name.';
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

  Widget emailField(BuildContext context) {
    return Flexible(
      flex: 1,
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
                        border: InputBorder.none,
                        labelText: 'Email',
                      ),
                      onSaved: (value) {
                        //newUser.email = value;
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

  Widget cityField(BuildContext context) {
    return Flexible(
      flex: 1,
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
                        border: InputBorder.none,
                        labelText: 'Enter City',
                      ),
                      onSaved: (value) {
                        //newUser.city = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your city.';
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

  Widget postalCodeField(BuildContext context) {
    return Flexible(
      flex: 1,
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
                        border: InputBorder.none,
                        labelText: 'Enter Postal Code',
                      ),
                      keyboardType: TextInputType.number,
                      onSaved: (value) {
                        //newUser.zipCode = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your postal code.';
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

  Widget stateField(BuildContext context) {
    return Flexible(
      flex: 1,
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
                        border: InputBorder.none,
                        labelText: 'Enter State',
                      ),
                      onSaved: (value) {
                        //newUser.state = value;
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your state.';
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

  Widget submitButton(BuildContext context) {
    return Flexible(
      flex: 1,
      child: addPadding(
        elevatedButtonStandard(
            'Submit',
            (() => {
              //TO_DO: query db, locate user data, check valid user,
              //navigate to new screen
            Navigator.of(context).pushNamed(LoginScreen.routeName),
            })
        ),
      ),
    );
  }

  Widget stateZipRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        stateField(context),
        postalCodeField(context),
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
                  /*if (adminChecked == false) {
                    newUser.role = publicUser;
                  } else {
                    newUser.role = admin;
                  }*/
                });
              },
          ),
        ),
        Text('I am a shelter admin',
          style: TextStyle(fontSize: 18, color: Colors.white)
        ),
      ],
    );
  }

  Widget addPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}
