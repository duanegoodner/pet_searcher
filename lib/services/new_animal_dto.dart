class AnimalDTO {
  String name;
  DateTime dateAdded;
  String type;
  String status;
  String breed;
  List<String> disposition = [];
  String age;
  String gender;
  String imageURL;

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
