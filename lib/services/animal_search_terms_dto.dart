import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AnimalSearchTermsDTO {
  String type;
  String breed;
  String gender;
  List<String> disposition;
  DateTimeRange dateAdded;

  AnimalSearchTermsDTO({
    this.type,
    this.breed,
    this.gender,
    this.disposition,
    this.dateAdded,
  });

  AnimalSearchTermsDTO.initial()
      : type = null,
        breed = null,
        gender = null,
        disposition = [],
        dateAdded = DateTimeRange(
          start: DateTime.utc(2018),
          end: DateTime.now(),
        );

  Map<String, dynamic> toJson() => {
        'type': type,
        'breed': breed,
        'gender': gender,
        'disposition': disposition,
        'dateAdded': dateAdded,
      };

  String get formattedDate =>
      '${DateFormat.yMMMd().format(dateAdded.start)} - ${DateFormat.yMMMd().format(dateAdded.end)}';
}
