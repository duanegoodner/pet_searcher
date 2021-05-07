class Animal {
  String name;
  DateTime dateAdded;
  String type;
  String status;
  String breed;
  String disposition;
  //List<String> disposition;
  String age;
  String gender;
  String imageURL;

  static const allFields = [
    'name',
    'dateAdded',
    'type',
    'status',
    'breed',
    'disposition',
    'age',
    'gender',
    'imageURL',
  ];

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

  Animal.nullAnimal()
      : name = '',
        dateAdded = DateTime.fromMicrosecondsSinceEpoch(0),
        type = 'nullType',
        status = '',
        breed = '',
        disposition = '',
        age = '',
        gender = '',
        imageURL = '';

  Animal.fromJSON(Map<String, dynamic> json) {
    name = json['name'];
    dateAdded = DateTime.fromMicrosecondsSinceEpoch(
        json['dateAdded'].microsecondsSinceEpoch);
    type = json['type'];
    status = json['status'];
    breed = json['breed'];
    disposition = json['disposition'];
    age = json['age'];
    gender = json['gender'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'dateAdded': dateAdded,
        'type': type,
        'status': status,
        'breed': breed,
        'disposition': disposition,
        'age': age,
        'gender': gender,
        'imageURL': imageURL
      };
}
