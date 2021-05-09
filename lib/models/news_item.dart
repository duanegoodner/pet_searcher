class NewsItem {
  String docID;
  String imageUrl;
  String title;
  String body;
  DateTime date;

  NewsItem({this.docID, this.imageUrl, this.title, this.body, this.date});

  factory NewsItem.fromJSON(Map<String, dynamic> json) {
    return NewsItem(
      docID: json['docID'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      body: json['body'],
      date: json['date'],
    );
  }

  NewsItem.fromMap(Map<String, dynamic> info) {
    this.docID = info['docID'];
    this.imageUrl = info['imageUrl'];
    this.title = info['title'];
    this.body = info['body'];
    this.date = info['date'];
  }
}
