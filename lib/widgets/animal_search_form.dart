import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal_category_constants.dart';
import 'package:pet_matcher/widgets/filter_dropdown_box.dart';

class AnimalSearchForm extends StatefulWidget {
  AnimalSearchForm({Key key}) : super(key: key);

  @override
  _AnimalSearchFormState createState() => _AnimalSearchFormState();
}

class _AnimalSearchFormState extends State<AnimalSearchForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final breedFieldKey = GlobalKey<FormFieldState>();
  bool isChecked = false;
  String selectedType;
  String selectedBreed;
  String breedFieldLabel = 'Choose animal type to view breeds';
  Function breedOnChanged;
  String selectedGender;
  String selectedDisposition;
  Map<String, bool> dispositionValues =
      Map.fromIterable(disposition, key: (e) => e, value: (e) => false);
  List<String> selectedDispositions = [];

  void getSelectedDispositions() {
    dispositionValues.forEach((key, value) {
      if (value) {
        selectedDispositions.add(key);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.blue[50],
      content: Container(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Column(
              //   children: [
              typeField(),
              SizedBox(
                height: 5,
              ),
              breedField(),
              SizedBox(
                height: 5,
              ),
              genderField(),
              SizedBox(height: 5),
              //   ],
              // ),
              ListView(
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
              ),
            ],
          ),
        ),
      ),
      title: Text('Search for Animals'),
      actions: <Widget>[
        ElevatedButton(
          child: Text('Submit'),
          onPressed: () {
            if (_formKey.currentState.validate()) {
              // Do something like updating SharedPreferences or User Settings etc.
              Navigator.of(context).pop();
            }
          },
        ),
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
