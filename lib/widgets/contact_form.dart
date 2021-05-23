import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pet_matcher/screens/user_home_screen.dart';
import 'package:pet_matcher/models/animal.dart';

import '../styles.dart';

class ContactForm extends StatefulWidget {

  final Animal animal;

  ContactForm({Key key, @required this.animal}) : super(key: key);

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Styles.popUpColor,
        content: Container(
            width: double.maxFinite,
            height: 450,
            child: FormBuilder(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: ListView(
                children: <Widget>[
                  formTextField('name', 'Full Name', 1),
                  formTextField('email', 'Email Address', 1),
                  formTextField('details', 'Please Type Your Message Here', 5),
                  contactButton(widget.animal),
                ],
              ),
            ),
        ),
    );
  }

  Widget formTextField(String name, String label, int maxLines){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FormBuilderTextField(
        name: name,
        maxLines: maxLines,
        validator: FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
        decoration: InputDecoration(
          labelText: label,
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          fillColor: Colors.white,
          filled: true,
        ),
      ),
    );
  }

  Widget contactButton(Animal animal) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ElevatedButton(
        child: Padding(
          padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
          child: Text('Match Me!'),
        ),
        onPressed: () {
          if(_formKey.currentState.saveAndValidate()) {
            FirebaseFirestore.instance.collection('message').add({
              'name': _formKey.currentState.value['name'],
              'email': _formKey.currentState.value['email'],
              'details': _formKey.currentState.value['details'],
              'interest': animal.name,
            });
            Navigator.of(context).pushReplacementNamed(UserHomeScreen.routeName);
          }
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.grey,
          onPrimary: Colors.white,
          textStyle: Styles.elevatedButtonText,
          shadowColor: Colors.black,
          elevation: 8,
          minimumSize: Size(5, 5),
        ),
      ),
    );
  }
}