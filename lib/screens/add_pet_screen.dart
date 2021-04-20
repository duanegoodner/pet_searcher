//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
import 'package:pet_matcher/widgets/standard_dropdown_box.dart';
import 'package:pet_matcher/widgets/standard_input_box.dart';

class AddPetScreen extends StatefulWidget {
  static const routeName = 'addPetScreen';

  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  List<String> items = <String>[
    'Male',
    'Female',
    'Other',
  ];
  final formKey = GlobalKey<FormState>();
  //final animalData = AnimalDTO();
  String _animalGenderChosen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Animal'),
        backgroundColor: Colors.blue[300],
      ),
      backgroundColor: Colors.blue[300],
      body: Center(
        child: SingleChildScrollView(
        child: Form(
            //key: formKey,
            /*code from video starts here
            autovalidateMode: AutovalidateMode.always,
            key: formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              children: <Widget>[
                animalNameField(context),
                animalGenderDropdownField(context),
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('age').snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      Text('Error');
                    } else {
                      List<DropdownMenuItem> ageTypes = [];
                      for (int i = 0; i < snapshot.data.documents.length; i++) {
                        DocumentSnapshot sshot = snapshot.data.document[i];
                        ageTypes.add(DropdownMenuItem(
                          child: Text(
                            sshot.documentID,
                          ),
                          value: '${sshot.documentID}',
                        ));
                      }
                    }
                  },
                )
              ],
            )
*/
            
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              logo(),
              animalNameField(context),
              animalGenderDropdownField(context),
              addAnimalButton(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Image.asset('assets/images/paw_logo.png',
        height: 250, width: 200, fit: BoxFit.fitWidth);
    //IDEA: wrap the image in a gestureDetector for selecting animal
    //image and then display in place of the image logo
  }

  Widget animalNameField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'Animal Name',
        validatorPrompt: 'Enter animal name.',
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {
          //
        });
  }

  Widget animalGenderDropdownField(BuildContext context) {
    return standardDropdownBox(
        labelText: 'Gender',
        validatorPrompt: 'Select a gender.',
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {},
        onChanged: (value) => _animalGenderChosen = value,
        items: items);
  }

  Widget dispositionField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'Disposition',
        validatorPrompt: 'Enter animal disposition.',
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {
          //
        });
  }

  Widget addAnimalButton(BuildContext context) {
    return addPadding(elevatedButtonStandard('Add animal', createAnimal));
  }

  void createAnimal() async {
    //save form
    //add animal to database
    //go to next screen
  }

  Widget addPadding(Widget child) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: child,
    );
  }
}
