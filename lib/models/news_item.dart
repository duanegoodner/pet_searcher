class NewsItem {
  String heading;
  String body;


  NewsItem(
      {this.heading,
        this.body});

  factory NewsItem.fromJSON(Map<String, dynamic> json) {
    return NewsItem(
      heading: json['heading'],
      body: json['body'],
    );
  }
}