import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/animal_category_constants.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/services/image_service.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
import 'package:pet_matcher/widgets/standard_dropdown_box.dart';
import 'package:pet_matcher/widgets/standard_input_box.dart';
import 'package:pet_matcher/widgets/standard_multi_select_chip_field.dart';

import '../styles.dart';

class AddPetScreen extends StatefulWidget {
  static const routeName = 'addPetScreen';

  @override
  _AddPetScreenState createState() => _AddPetScreenState();
}

class _AddPetScreenState extends State<AddPetScreen> {
  final formKey = GlobalKey<FormState>();
  Animal receivedAnimal = Animal();
  bool _imageLoading = false;

  final Map<String, bool> dispositionValues =
      Map.fromIterable(disposition, key: (e) => e, value: (e) => false);
  String imageUrl;

  // @override
  // void initState() {
  //   super.initState();
  //   getImageUrl();
  // }

  void getImageUrl() async {
    receivedAnimal.imageURL = await retrieveImageUrl();
    _imageLoading = false;
    setState(() {});
  }

  Widget build(BuildContext context) {
    // if (imageUrl == null) {
    //   return Center(child: CircularProgressIndicator());
    // }

    var receivedArgument = ModalRoute.of(context).settings.arguments;
    //if receivedArgument is String, the animal is a new animal
    if (receivedArgument is String) {
      receivedAnimal.type = '$receivedArgument';
      receivedAnimal.dateAdded = DateTime.now();
    }
    //if receivedArgument is an Animal object, the animal already exists in database
    else {
      receivedAnimal = receivedArgument;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add ${receivedAnimal.type}'),
        backgroundColor: Styles.appBarColor,
      ),
      backgroundColor: Styles.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                imageField(),
                animalNameField(context),
                chooseAnimalBreedField(context, receivedAnimal.type),
                animalAgeField(context, age),
                animalGenderDropdownField(context, gender),
                animalStatusField(context, adoptionStatus),
                animalDispositionField(),
                addAnimalButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getChosenAnimalImage() {
    return Padding(
        padding: EdgeInsets.only(top: 20, bottom: 10),
        child: SizedBox(
          height: 250,
          width: 200,
          child: Icon(Icons.image_search),
        ));
  }

  Widget imageField() {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: GestureDetector(
        onTap: getImageUrl,
        child: imageDisplaySelector(),
      ),
    );
  }

  // Widget displayedImage() {
  //   return Padding(
  //       padding: EdgeInsets.only(top: 20, bottom: 10),
  //       child: SizedBox(
  //         height: 250,
  //         width: 200,
  //         child: imageDisplaySelector(),
  //       ));

  //   // return Padding(
  //   //     padding: EdgeInsets.only(top: 20, bottom: 10),
  //   //     child: Image.network(receivedAnimal.imageURL,
  //   //         height: 250, width: 200, fit: BoxFit.fitWidth));
  // }

  Widget imageDisplaySelector() {
    if (_imageLoading) {
      return SizedBox(
        height: 250,
        width: 250,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (receivedAnimal.imageURL == null) {
      return SizedBox(
        height: 250,
        width: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image_search, size: 100),
            Text('Select an Image'),
          ],
        ),
      );
    }
    return Column(
      children: [
        SizedBox(
          height: 250,
          width: 250,
          child: CachedNetworkImage(
              placeholder: (_, __) =>
                  Center(child: CircularProgressIndicator()),
              imageUrl: receivedAnimal.imageURL,
              fit: BoxFit.cover),
        ),
        Text('Tap on Image to Edit')
      ],
    );
  }

  Widget animalNameField(BuildContext context) {
    String initialValue;
    if (receivedAnimal.animalID != null) {
      initialValue = receivedAnimal.name;
    }

    return standardInputBoxWithoutFlex(
        labelText: 'Animal Name',
        validatorPrompt: 'Enter animal name.',
        initialValue: initialValue,
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {
          receivedAnimal.name = value;
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
    String initialValue;
    if (receivedAnimal.animalID != null) {
      initialValue = receivedAnimal.breed;
    }

    return standardDropdownBox(
      labelText: 'Breed',
      validatorPrompt: 'Select a breed/type.',
      validatorCondition: (value) => value.isEmpty,
      onSaved: (value) {
        receivedAnimal.breed = value;
      },
      chosenResponse: initialValue,
      items: categories,
    );
  }

  Widget animalAgeField(context, categories) {
    String initialValue;
    if (receivedAnimal.animalID != null) {
      initialValue = receivedAnimal.age;
    }

    return standardDropdownBox(
      labelText: 'Age',
      validatorPrompt: 'Select age category.',
      validatorCondition: (value) => value.isEmpty,
      onSaved: (value) {
        receivedAnimal.age = value;
      },
      chosenResponse: initialValue,
      items: categories,
    );
  }

  Widget animalGenderDropdownField(BuildContext context, categories) {
    String initialValue;
    if (receivedAnimal.animalID != null) {
      initialValue = receivedAnimal.gender;
    }

    return standardDropdownBox(
      labelText: 'Gender',
      validatorPrompt: 'Select a gender.',
      validatorCondition: (value) => value.isEmpty,
      onSaved: (value) {
        receivedAnimal.gender = value;
      },
      chosenResponse: initialValue,
      items: categories,
    );
  }

  Widget animalStatusField(context, categories) {
    String initialValue;
    if (receivedAnimal.animalID != null) {
      initialValue = receivedAnimal.status;
    }

    return standardDropdownBox(
      labelText: 'Status',
      validatorPrompt: 'Select an animal status.',
      validatorCondition: (value) => value.isEmpty,
      onSaved: (value) {
        receivedAnimal.status = value;
      },
      chosenResponse: initialValue,
      items: categories,
    );
  }

  Widget animalDispositionField() {
    return addPadding(
      DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.white,
          ),
        ),
        child: Column(
          children: [
            dispositionHeader(),
            dispositionMultiSelect(),
          ],
        ),
      ),
    );
  }

  Widget dispositionHeader() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        'Disposition (select all that apply)',
        style: Styles.dispositionHeaderWhite,
      ),
    );
  }

  Widget dispositionMultiSelect() {
    List<dynamic> initialValues;
    if (receivedAnimal.animalID != null) {
      initialValues = receivedAnimal.disposition;
    }

    return standardMultiSelectChipField(
      options: disposition,
      onTap: (values) {
        receivedAnimal.disposition = values;
      },
      validatorCondition: (values) => values == null || values.length == 0,
      validatorPrompt: 'Please select at least one disposition',
      initialValues: initialValues,
    );
  }

  Widget addAnimalButton(BuildContext context) {
    //determine if a new animal is being added or a previous animal is being edited
    if (receivedAnimal.animalID == null) {
      return addPadding(elevatedButtonStandard('Submit', createAnimal));
    } else {
      return addPadding(elevatedButtonStandard('Submit', editAnimal));
    }
  }

  Future<void> createAnimal() async {
    if (formKey.currentState.validate()) {
      try {
        //save form
        formKey.currentState.save();
        //add animal to database
        FirebaseFirestore.instance.collection('animals').add({
          'name': receivedAnimal.name,
          'dateAdded': DateTime.parse('${receivedAnimal.dateAdded}'),
          'type': receivedAnimal.type,
          'breed': receivedAnimal.breed,
          'age': receivedAnimal.age,
          'gender': receivedAnimal.gender,
          'status': receivedAnimal.status,
          'disposition': receivedAnimal.disposition,
          'imageURL': receivedAnimal.imageURL,
        });
        //navigate back to admin home screen
        Navigator.of(context).pushReplacementNamed(AdminHomeScreen.routeName);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> editAnimal() async {
    if (formKey.currentState.validate()) {
      try {
        //save form
        formKey.currentState.save();
        //edit/update animal in the database
        FirebaseFirestore.instance
            .collection('animals')
            .doc('${receivedAnimal.animalID}')
            .set({
          'name': receivedAnimal.name,
          'dateAdded': DateTime.parse('${receivedAnimal.dateAdded}'),
          'type': receivedAnimal.type,
          'breed': receivedAnimal.breed,
          'age': receivedAnimal.age,
          'gender': receivedAnimal.gender,
          'status': receivedAnimal.status,
          'disposition': receivedAnimal.disposition,
          'imageURL': receivedAnimal.imageURL,
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
