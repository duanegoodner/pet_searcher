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
}
