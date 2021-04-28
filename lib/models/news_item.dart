class NewsItem {
  String imageUrl;
  String title;
  String body;
  DateTime date;

  NewsItem({this.imageUrl, this.title, this.body, this.date});

  factory NewsItem.fromJSON(Map<String, dynamic> json) {
    return NewsItem(
      imageUrl: json['imageUrl'],
      title: json['title'],
      body: json['body'],
      date: json['date'],
    );
  }

  NewsItem.fromMap(Map<String, dynamic> info) {
    this.imageUrl = info['imageUrl'];
    this.title = info['title'];
    this.body = info['body'];
    this.date = info['date'];
  }
}
