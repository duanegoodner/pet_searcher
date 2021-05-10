import 'package:flutter/material.dart';
import 'package:pet_matcher/models/animal.dart';

class AnimalFilter extends ChangeNotifier {
  AnimalFilter();

  Map<String, dynamic> _searchCriteria = Map.fromIterable(
    Animal.allFields,
    key: (field) => field,
    value: (field) => null,
  );

  String _sortCriteria = 'dateAdded';

  Map<String, dynamic> get searchCriteria => _searchCriteria;

  String get sortCriteria => _sortCriteria;

  void update(Map<String, dynamic> newCriteria) {
    newCriteria.forEach((property, function) {
      _searchCriteria[property] = newCriteria[property];
    });
    notifyListeners();
  }

  void updateSortCriteria(String newCriteria) {
    _sortCriteria = newCriteria;
    notifyListeners();
  }
}
