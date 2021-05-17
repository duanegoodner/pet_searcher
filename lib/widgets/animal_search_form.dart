import 'package:flutter/material.dart';
import 'package:pet_matcher/services/animal_search_terms_dto.dart';
import 'package:provider/provider.dart';
import 'package:pet_matcher/models/animal_category_constants.dart';
import 'package:pet_matcher/models/animal_filter.dart';
import 'package:pet_matcher/widgets/animal_disposition_field.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
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

  String dateRangeDisplay = 'Tap to select';

  // Use a map of disposition values when form is active
  // Will collect any keys w/ val == true into List<String> upon Submit
  Map<String, bool> dispositionValues =
      Map.fromIterable(disposition, key: (e) => e, value: (e) => false);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              typeField(),
              SizedBox(height: 10),
              breedField(),
              SizedBox(height: 10),
              genderField(),
              SizedBox(height: 10),
              animalDispositionField(),
              SizedBox(height: 10),
              dateRangeField(context),
              SizedBox(height: 10),
              searchButton(
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchButton(BuildContext context) {
    return elevatedButtonStandard('Search', searchFunction);
  }

  void searchFunction() {
    if (_formKey.currentState.validate()) {
      Provider.of<AnimalFilter>(context, listen: false)
          .updateSearchCriteria(newCriteria: searchTerms.toJson());
      Navigator.of(context).pop();
    }
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

  Widget dateRangeField(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        searchTerms.dateAdded = await showDateRangePicker(
            context: context,
            firstDate: DateTime.utc(2018),
            lastDate: DateTime.now());
        dateRangeDisplay = searchTerms.formattedDate;
        setState(() {});
      },
      child: Text(
        'Date Range: $dateRangeDisplay',
      ),
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

  Widget fromDateField() {
    return InputDatePickerFormField(
      fieldLabelText: 'Start',
      firstDate: DateTime.utc(2019, 1, 1),
      lastDate: DateTime.now(),
    );
  }

  Widget toDateField() {
    return InputDatePickerFormField(
      fieldLabelText: 'Start',
      firstDate: DateTime.utc(2019, 1, 1),
      lastDate: DateTime.now(),
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

  Widget animalDispositionField() {
    return standardDispositionField(
      headerTitle: 'Disposition',
      options: disposition,
      onTap: (values) {
        searchTerms.disposition = values;
      },
      validatorCondition: (values) => false,
      validatorPrompt: '',
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
