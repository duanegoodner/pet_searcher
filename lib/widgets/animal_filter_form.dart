import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal_category_constants.dart';

import 'package:pet_matcher/widgets/filter_dropdown_box.dart';

class AnimalFilterForm extends StatefulWidget {
  AnimalFilterForm({Key key}) : super(key: key);

  @override
  _AnimalFilterFormState createState() => _AnimalFilterFormState();
}

class _AnimalFilterFormState extends State<AnimalFilterForm> {
  final formKey = GlobalKey<FormState>();
  final breedFieldKey = GlobalKey<FormFieldState>();
  String selectedType;
  String selectedBreed;
  String breedFieldLabel = 'Choose animal type to view breeds';
  Function breedOnChanged;
  String selectedGender;
  String selectedDisposition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Form(
        key: formKey,
        child: formContent(context),
      ),
    );
  }

  Widget formContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: typeField(),
            ),
            Expanded(
              child: genderField(),
            ),
          ],
        ),
        breedField(),
        dispositionField(),
      ],
    );
  }

  Widget typeField() {
    return filterDropDownBox(
      labelText: 'Animal type',
      items: animalType,
      value: selectedType,
      onChanged: (value) {
        selectedType = value;
        breedFieldKey.currentState.reset();
        breedOnChanged = (value) {};
        breedFieldLabel = 'Breed';
        setState(() {});
      },
    );
  }

  Widget breedField() {
    return filterDropDownBox(
      key: breedFieldKey,
      labelText: breedFieldLabel,
      items: breedOptions(),
      value: selectedBreed,
      onChanged: breedOnChanged,
      // disabledHint: 'Choose an animal type to view breeds'
    );
  }

  List<String> breedOptions() {
    if (selectedType == 'Dog') {
      return dogBreeds;
    }
    if (selectedType == 'Cat') {
      return catBreeds;
    }
    if (selectedType == 'Other') {
      return otherAnimalTypes;
    }
    return [''];
  }

  Widget genderField() {
    return filterDropDownBox(
      labelText: 'Gender',
      items: gender,
      value: selectedGender,
      onChanged: (value) {},
    );
  }

  Widget dispositionField() {
    return filterDropDownBox(
      labelText: 'Disposition',
      items: disposition,
      value: selectedDisposition,
      onChanged: (value) {},
    );
  }
}
