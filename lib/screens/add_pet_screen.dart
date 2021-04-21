//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal_category_constants.dart';
import 'package:pet_matcher/services/new_animal_dto.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
import 'package:pet_matcher/widgets/standard_dropdown_box.dart';
import 'package:pet_matcher/widgets/standard_input_box.dart';

class AddPetScreen extends StatefulWidget {
  static const routeName = 'addPetScreen';

  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final formKey = GlobalKey<FormState>();
  final newAnimalData = AnimalDTO();

  @override
  Widget build(BuildContext context) {
    newAnimalData.dateAdded = DateTime.now();
    //NOTE: will need to change this when we have an actual image
    newAnimalData.imageURL = 'fakeanimalimageurl.com';
    //NOTE: will get type from navigator from admin home page
    newAnimalData.type = 'dog';
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
            key: formKey,
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
              //FIX: add logic to determine which breed list is displayed
              animalBreedField(context, dogBreeds),
              animalAgeField(context, age),
              animalGenderDropdownField(context, gender),
              animalStatusField(context, adoptionStatus),
              animalDispositionField(context, disposition),
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
          newAnimalData.name = value;
        });
  }

  Widget animalBreedField(context, categories) {
    return standardDropdownBox(
      labelText: 'Breed',
      validatorPrompt: 'Select a breed/type.',
      validatorCondition: (value) => value.isEmpty,
      onSaved: (value) {
        newAnimalData.breed = value;
      },
      items: categories,
    );
  }

  Widget animalAgeField(context, categories) {
    return standardDropdownBox(
      labelText: 'Age',
      validatorPrompt: 'Select age category.',
      validatorCondition: (value) => value.isEmpty,
      onSaved: (value) {
        newAnimalData.age = value;
      },
      items: categories,
    );
  }

  Widget animalGenderDropdownField(BuildContext context, categories) {
    return standardDropdownBox(
      labelText: 'Gender',
      validatorPrompt: 'Select a gender.',
      validatorCondition: (value) => value.isEmpty,
      onSaved: (value) {
        newAnimalData.gender = value;
      },
      items: categories,
    );
  }

  Widget animalStatusField(context, categories) {
    return standardDropdownBox(
      labelText: 'Status',
      validatorPrompt: 'Select an animal status.',
      validatorCondition: (value) => value.isEmpty,
      onSaved: (value) {
        newAnimalData.status = value;
      },
      items: categories,
    );
  }

  //NOTE: need to change to a dropdown with checkboxes
  Widget animalDispositionField(context, categories) {
    return standardDropdownBox(
      labelText: 'Disposition',
      validatorPrompt: 'Select all that apply.',
      validatorCondition: (value) => value.isEmpty,
      onSaved: (value) {
        newAnimalData.disposition = value;
      },
      items: categories,
    );
  }

  Widget addAnimalButton(BuildContext context) {
    return addPadding(elevatedButtonStandard('Add animal', createAnimal));
  }

  Future<void> createAnimal() async {
    if (formKey.currentState.validate()) {
      try {
        //save form
        formKey.currentState.save();
        //add animal to database
        FirebaseFirestore.instance.collection('animals').add({
          'name': newAnimalData.name,
          'dateAdded': DateTime.parse('${newAnimalData.dateAdded}'),
          'type': newAnimalData.type,
          'breed': newAnimalData.breed,
          'age': newAnimalData.age,
          'gender': newAnimalData.gender,
          'status': newAnimalData.status,
          'disposition': newAnimalData.disposition,
          'imageURL': newAnimalData.imageURL,
        });
        //NOTE: go back to admin homescreen
        //Navigator.of(context).pushNamed(AdminScreen.routeName);
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
}
