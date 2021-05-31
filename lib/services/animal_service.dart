import 'dart:async';
//import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_matcher/models/animal.dart';
//import 'package:flutter/services.dart';

class AnimalService {
  final CollectionReference _animalCollection =
      FirebaseFirestore.instance.collection('animals');
  final Query _availableAnimalCollection = FirebaseFirestore.instance
      .collection('animals')
      .where('status', isEqualTo: 'Available');

  final List<String> args;

  AnimalService({this.args});

  Stream<List<Animal>> animalStream() {
    return _animalCollection.snapshots().map((snapshot) {
      if (snapshot.docs.length != 0) {
        return snapshot.docs
            .map(
              (animalEntry) => Animal.fromJSON(
                animalEntry.data(),
                animalEntry.id,
              ),
            )
            .toList();
      } else {
        // TO DO: change logic for no animals in database
        return [null];
      }
    });
  }

  Stream<List<Animal>> availableAnimalStream() {
    return _availableAnimalCollection.snapshots().map((snapshot) => snapshot
        .docs
        .map((animalEntry) =>
            Animal.fromJSON(animalEntry.data(), animalEntry.id))
        .toList());
  }

  List<Animal> filterAnimalList(
      Map<String, dynamic> searchCriteria, List<Animal> animals) {
    Map<String, dynamic> queriedParams = Map();

    Animal.allFields.forEach((property) {
      if (searchCriteria[property] != null) {
        queriedParams[property] = searchCriteria[property];
      }
    });

    return animals
        ?.map((animal) {
          if (queriedParams.entries.every((entry) =>
              meetsCriteria(animal.toJson()[entry?.key], entry?.value))) {
            return animal;
          }
        })
        ?.toList()
        ?.whereType<Animal>()
        ?.toList();
  }

  bool meetsCriteria(dynamic animalValue, dynamic searchValue) {
    if (animalValue is String) {
      return animalValue == searchValue;
    }
    if (animalValue is List) {
      if (searchValue.length == 0) {
        return true;
      }
      return (animalValue.any((item) => searchValue.contains(item)));
    }
    if (animalValue is DateTime) {
      if ((searchValue.start != null &&
              animalValue.isBefore(searchValue.start)) ||
          (searchValue.end != null && animalValue.isAfter(searchValue.end))) {
        return false;
      }
      return true;
    }
    return animalValue == searchValue;
  }

  Stream<List<Animal>> filteredAnimalStream({
    String age,
    String breed,
    String disposition,
    String gender,
    String type,
  }) {
    Map<String, dynamic> queriedParams = Map();
    ({
      'age': age,
      'breed': breed,
      'disposition': disposition,
      'gender': gender,
      'type': type
    }).forEach((key, value) {
      if (value != null) queriedParams[key] = value;
    });

    return _animalCollection.snapshots().map((snapshot) => snapshot.docs
        .map((animalEntry) {
          if (queriedParams.entries
              .every((entry) => animalEntry[entry.key] == entry.value)) {
            return Animal.fromJSON(animalEntry.data(), animalEntry.id);
          }
        })
        .toList()
        .whereType<Animal>()
        .toList());
  }

  Stream<List<Animal>> dogListStream() {
    return _animalCollection.snapshots().map((snapshot) => snapshot.docs
        .map((animalEntry) {
          if (animalEntry['type'] == 'Dog') {
            return Animal.fromJSON(animalEntry.data(), animalEntry.id);
          }
        })
        .toList()
        .whereType<Animal>()
        .toList());
  }

  Stream animalDataStream() {
    return _animalCollection.snapshots();
  }
}
