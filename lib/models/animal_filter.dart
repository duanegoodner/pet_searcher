import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:provider/provider.dart';

class AnimalFilter extends ChangeNotifier {
  Map<String, bool Function(Animal)> _searchCriteria = Map.fromIterable(
    Animal.allFields,
    key: (field) => field,
    value: (field) => (Animal animal) => true,
  );

  Map<String, bool Function(Animal)> get searchCriteria => _searchCriteria;
  String state = 'something';

  void update() {
    Animal.allFields.forEach((animalProperty) {
      // if (newCriteria[animalProperty] != null) {
      //   print(_searchCriteria[animalProperty] == newCriteria[animalProperty]);
      //   _searchCriteria[animalProperty] = newCriteria[animalProperty];
      // }
    });
    _searchCriteria = Map.fromIterable(
      Animal.allFields,
      key: (field) => field,
      value: (field) => (Animal animal) => false,
    );
    state = 'something else';
    print(state);
    notifyListeners();
  }
}
