import 'animal_enums.dart';

class Animal {
  String name;
  DateTime dateAdded;
  AnimalType type;
  AdoptionStatus status;
  AnimalBreed breed;
  String disposition;
  Age age;
  Gender gender;
  String imageURL;

  Animal(
      {this.name,
      this.dateAdded,
      this.type,
      this.status,
      this.breed,
      this.disposition,
      this.age,
      this.gender,
      this.imageURL});

  factory Animal.fromJSON(Map<String, dynamic> json) {
    return Animal(
      name: json['name'],
      dateAdded: json['dateAdded'],
      type: json['type'],
      status: json['status'],
      breed: json['breed'],
      disposition: json['disposition'],
      age: json['age'],
      gender: json['gender'],
      imageURL: json['imageURL'],
    );
  }

  //may need to move to animal_dto.dart file
  Map<String, dynamic> toJson() => {
        'name': name,
        'dateAdded': dateAdded,
        'type': type,
        'adoptionStatus': status,
        'breed': breed,
        'disposition': disposition,
        'age': age,
        'gender': gender,
        'imageURL': imageURL,
      };
}
