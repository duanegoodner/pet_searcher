import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal.dart';

class InventoryFilter extends ChangeNotifier {
  Map<String, bool Function(Animal animal)> _searchCriteria = Map.fromIterable(
      Animal.allFields,
      key: (field) => field,
      value: (field) => (animal) => true);

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
