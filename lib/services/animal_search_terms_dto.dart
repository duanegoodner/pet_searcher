class AnimalSearchTermsDTO {
  String type;
  String breed;
  String gender;
  List<String> disposition;

  AnimalSearchTermsDTO({
    this.type,
    this.breed,
    this.gender,
    this.disposition,
  });

  AnimalSearchTermsDTO.initial()
      : type = null,
        breed = null,
        gender = null,
        disposition = [];

  Map<String, dynamic> toJson() => {
        'type': type,
        'breed:': breed,
        'gender': gender,
        'disposition': disposition,
      };
}
