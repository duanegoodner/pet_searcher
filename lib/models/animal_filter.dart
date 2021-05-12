import 'package:flutter/material.dart';
import 'package:pet_matcher/services/animal_search_terms_dto.dart';

class AnimalFilter extends ChangeNotifier {
  AnimalFilter();

  final _searchCriteria = AnimalSearchTermsDTO().toJson();

  String _sortCriteria = 'dateAdded';

  Map<String, dynamic> get searchCriteria => _searchCriteria;

  String get sortCriteria => _sortCriteria;

  void update(Map<String, dynamic> newCriteria) {
    newCriteria.forEach((property, function) {
      _searchCriteria[property] = newCriteria[property];
    });
    notifyListeners();
  }

  // The call to re-sort takes place in selected item callback
  // So really only using notifyListeners here, but may change later
  void updateSortCriteria(String newCriteria) {
    _sortCriteria = newCriteria;
    notifyListeners();
  }
}
