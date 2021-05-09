import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/services/animal_service.dart';

class FilteredAnimalList extends ChangeNotifier {
  final Locator providerLocator;
  List<Animal> filteredList;

  FilteredAnimalList({this.providerLocator, this.filteredList});

  FilteredAnimalList.unfiltered(Locator providerLocator)
      : providerLocator = providerLocator,
        filteredList = providerLocator<List<Animal>>();

  Map<String, bool Function(Animal)> _searchCriteria = Map.fromIterable(
    Animal.allFields,
    key: (field) => field,
    value: (field) => (Animal animal) => true,
  );

  void update(Map<String, bool Function(Animal)> newCriteria) {
    Animal.allFields.forEach((animalProperty) {
      if (newCriteria[animalProperty] != null) {
        _searchCriteria[animalProperty] = newCriteria[animalProperty];
      }
    });
    filteredList = locator<AnimalService>().filterAnimalList(
      _searchCriteria,
      providerLocator<List<Animal>>(),
    );
    notifyListeners();
  }
}
