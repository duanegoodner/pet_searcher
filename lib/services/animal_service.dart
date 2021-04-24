import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:pet_matcher/models/animal.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<QuerySnapshot> allAnimalSnapshot() async {
    QuerySnapshot _allAnimalData = await _animalCollection.get();
    return _allAnimalData;
  }

  Stream animalDataStream() {
    return _animalCollection.snapshots();
  }
}
