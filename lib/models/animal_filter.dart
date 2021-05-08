import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal.dart';

class AnimalFilter extends ChangeNotifier {
  final String screenName;

  AnimalFilter({this.screenName});

  Map<String, bool Function(Animal)> _searchCriteria = Map.fromIterable(
    Animal.allFields,
    key: (field) => field,
    value: (field) => (Animal animal) => true,
  );

  Map<String, bool Function(Animal)> get searchCriteria => _searchCriteria;

  void update(Map<String, bool Function(Animal)> newCriteria) {
    Animal.allFields.forEach((animalProperty) {
      if (newCriteria[animalProperty] != null) {
        _searchCriteria[animalProperty] = newCriteria[animalProperty];
      }
    });
    notifyListeners();
  }
}
