//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal_category_constants.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/services/image_service.dart';
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
  final Map<String, bool> dispositionValues =
      Map.fromIterable(disposition, key: (e) => e, value: (e) => false);
  String imageUrl;

  @override
  void initState() {
    super.initState();
    getImageUrl();
  }

  void getImageUrl() async {
    imageUrl = await retrieveImageUrl();
    setState(() {});
  }

  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return Center(child: CircularProgressIndicator());
    }
    String receivedAnimalType = ModalRoute.of(context).settings.arguments;
    newAnimalData.dateAdded = DateTime.now();
    newAnimalData.imageURL = imageUrl;
    newAnimalData.type = '$receivedAnimalType';
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add $receivedAnimalType'),
        backgroundColor: Colors.blue[300],
      ),
      backgroundColor: Colors.blue[300],
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              getChosenAnimalImage(),
              animalNameField(context),
              chooseAnimalBreedField(context, receivedAnimalType),
              animalAgeField(context, age),
              animalGenderDropdownField(context, gender),
              animalStatusField(context, adoptionStatus),
              dispositionField(),
              // animalDispositionField(context, disposition),
              addAnimalButton(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget getChosenAnimalImage() {
    return Padding(
        padding: EdgeInsets.only(top: 20, bottom: 10),
        child: Image.network('$imageUrl',
            height: 250, width: 200, fit: BoxFit.fitWidth));
  }

  /*
  Widget logo() {
    return Image.asset('assets/images/paw_logo.png',
        height: 250, width: 200, fit: BoxFit.fitWidth);
  }
  */

  Widget animalNameField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'Animal Name',
        validatorPrompt: 'Enter animal name.',
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {
          newAnimalData.name = value;
        });
  }

  Widget chooseAnimalBreedField(context, animalType) {
    if (animalType == 'Dog') {
      return animalBreedField(context, dogBreeds);
    } else if (animalType == 'Cat') {
      return animalBreedField(context, catBreeds);
    } else {
      return animalBreedField(context, otherAnimalTypes);
    }
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

  Widget dispositionField() {
    return ListView(
      shrinkWrap: true,
      children: dispositionValues.keys.map(
        (key) {
          return CheckboxListTile(
            title: Text(key),
            value: dispositionValues[key],
            onChanged: (value) {
              setState(
                () {
                  dispositionValues[key] = value;
                },
              );
            },
          );
        },
      ).toList(),
    );
  }

  void collectDispositions() {
    dispositionValues.forEach(
      (key, value) {
        if (value) {
          newAnimalData.disposition.add(key.toString());
        }
      },
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
        collectDispositions();
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
        //navigate back to admin home screen
        Navigator.of(context).pushReplacementNamed(AdminHomeScreen.routeName);
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
