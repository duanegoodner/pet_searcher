class UserFavorites {
  List<dynamic> favorites = [];

  UserFavorites({this.favorites});

  UserFavorites.initial() : favorites = [];

  UserFavorites.fromJSON(Map<String, dynamic> json) {
    favorites = json['favorites'];
  }
}
