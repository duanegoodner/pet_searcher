import 'package:flutter/material.dart';
import 'package:pet_matcher/services/animal_search_terms_dto.dart';
import 'package:provider/provider.dart';
import 'package:pet_matcher/models/animal_category_constants.dart';
import 'package:pet_matcher/models/animal_filter.dart';
import 'package:pet_matcher/widgets/filter_dropdown_box.dart';

class AnimalSearchForm extends StatefulWidget {
  AnimalSearchForm({Key key}) : super(key: key);

  @override
  _AnimalSearchFormState createState() => _AnimalSearchFormState();
}

class _AnimalSearchFormState extends State<AnimalSearchForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final searchTerms = AnimalSearchTermsDTO.initial();

  // part of logic that makes breed selectable onlyh if type selected
  final breedFieldKey = GlobalKey<FormFieldState>();
  String breedFieldLabel = 'Choose animal type to view breeds';
  Function breedOnChanged;

  // Use a map of disposition values when form is active
  // Will collect any keys w/ val == true into List<String> upon Submit
  Map<String, bool> dispositionValues =
      Map.fromIterable(disposition, key: (e) => e, value: (e) => false);

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
              typeField(),
              SizedBox(height: 5),
              breedField(),
              SizedBox(height: 5),
              genderField(),
              SizedBox(height: 5),
              dispositionField(),
            ],
          ),
        ),
      ),
      title: Text('Search for Animals'),
      actions: <Widget>[
        searchButton(context),
      ],
    );
  }

  Widget searchButton(BuildContext context) {
    return ElevatedButton(
      child: Text('Submit'),
      onPressed: () {
        if (_formKey.currentState.validate()) {
          collectDispositions();
          Provider.of<AnimalFilter>(context, listen: false)
              .update(searchTerms.toJson());
          Navigator.of(context).pop();
        }
      },
    );
  }

  Widget typeField() {
    return filterDropDownBox(
      labelText: 'Animal type',
      items: animalType,
      value: searchTerms.type,
      onChanged: (value) {
        searchTerms.type = value;
        breedFieldKey.currentState.reset();
        breedOnChanged = (value) {
          searchTerms.breed = value;
        };
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
      value: searchTerms.breed,
      onChanged: breedOnChanged,
    );
  }

  List<String> breedOptions() {
    if (searchTerms.type == 'Dog') {
      return dogBreeds;
    }
    if (searchTerms.type == 'Cat') {
      return catBreeds;
    }
    if (searchTerms.type == 'Other') {
      return otherAnimalTypes;
    }
    return [''];
  }

  Widget genderField() {
    return filterDropDownBox(
      labelText: 'Gender',
      items: gender,
      value: searchTerms.gender,
      onChanged: (value) {
        searchTerms.gender = value;
      },
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
          searchTerms.disposition.add(key);
        }
      },
    );
  }
}
