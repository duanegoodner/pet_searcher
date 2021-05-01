import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:flutter/services.dart';

class AnimalService {
  static const _animal_schema_path = 'assets/db/schema/animal_attributes.json';
  final CollectionReference _schema =
      FirebaseFirestore.instance.collection('schema');
  final CollectionReference _animalCollection =
      FirebaseFirestore.instance.collection('animals');

  final List<String> args;

  AnimalService({this.args});

  void resetAttributes() async {
    String _attributeData = await rootBundle.loadString(_animal_schema_path);
    final _attributeJson = jsonDecode(_attributeData);
    await _schema.doc('animals').set(_attributeJson);
  }

  Future<List<Animal>> getAllAnimals() async {
    QuerySnapshot _allAnimalData = await _animalCollection.get();
    List<QueryDocumentSnapshot> dataList = _allAnimalData.docs;

    return dataList.map((entry) => Animal.fromJSON(entry.data())).toList();
  }

  Stream<List<Animal>> animalStream() {
    return _animalCollection.snapshots().map((snapshot) => snapshot.docs
        .map((animalEntry) => Animal.fromJSON(animalEntry.data()))
        .toList());
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
            return Animal.fromJSON(animalEntry.data());
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
            return Animal.fromJSON(animalEntry.data());
          }
        })
        .toList()
        .whereType<Animal>()
        .toList());
  }

  Future<QuerySnapshot> allAnimalSnapshot() async {
    QuerySnapshot _allAnimalData = await _animalCollection.get();
    return _allAnimalData;
  }

  Stream animalDataStream() {
    return _animalCollection.snapshots();
  }
}
