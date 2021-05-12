import 'package:flutter/material.dart';
import 'package:pet_matcher/services/animal_service.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/services/animal_search_terms_dto.dart';
import 'package:pet_matcher/locator.dart';

class AnimalFilter extends ChangeNotifier {
  AnimalFilter();

  List<Animal> _incomingList;
  List<Animal> _outputList;

  final _searchCriteria = AnimalSearchTermsDTO().toJson();

  String _sortCriteria = 'dateAdded';

  Map<String, dynamic> get searchCriteria => _searchCriteria;

  String get sortCriteria => _sortCriteria;

  List<Animal> get outputList => _outputList;

  void computeOutputList() {
    _outputList = locator<AnimalService>()
        ?.filterAnimalList(_searchCriteria, _incomingList);
    _outputList?.sort((a, b) =>
        a.toJson()[_sortCriteria].compareTo(b.toJson()[_sortCriteria]));
  }

  void updateIncomingList(List<Animal> newAnimalList) {
    _incomingList = newAnimalList;
    computeOutputList();
    notifyListeners();
  }

  void updateSearchCriteria({Map<String, dynamic> newCriteria}) {
    newCriteria.forEach((property, function) {
      _searchCriteria[property] = newCriteria[property];
      computeOutputList();
      notifyListeners();
    });
    notifyListeners();
  }

  void updateSortCriteria(String newCriteria) {
    _sortCriteria = newCriteria;
    computeOutputList();
    notifyListeners();
  }
}
