import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_matcher/models/news_item.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = 'newsScreen';

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('News Feed'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: AdminDrawer(),
      backgroundColor: Colors.blue[300],
      body: buildListFromStream(context),
    );
  }

  Widget buildListFromStream(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('newsPost')
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data.docs != null &&
              snapshot.data.docs.length > 0) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) =>
                    _buildNewsItem(context, snapshot.data.docs[index]),
              ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Text('Error!');
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildNewsItem(BuildContext context, DocumentSnapshot document) {
    DateTime date = convertTimestampToDateTime(document['date']);
    String formattedDate = formatDate(date);

    NewsItem post = NewsItem.fromMap({
      'date': date,
      'imageUrl': document['imageUrl'],
      'title': document['title'],
      'body': document['body'],
    });

    return newsCard(post.imageUrl, post.title, post.body, formattedDate);
  }

  Widget newsCard(String imageUrl, String title, String body, String date) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 275,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(child: Image.network('$imageUrl')),
            ListTile(
                title: addPadding(
                  Text(
                    '$title',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ),
                subtitle: addPadding(
                  Text(
                    '$body',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Text(
                      '$date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border_outlined),
                        onPressed: () {
                          //NOTE: Still need to allow for selecting favorites
                          //and adding to favorite screen if we want to do that
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.share_outlined),
                        onPressed: () {
                          //NOTE: Still need to allow for sharing article
                        },
                      ),
                      //NOTE: will not need this icon for the user news feed page
                      IconButton(
                        icon: Icon(Icons.edit_outlined),
                        onPressed: () {
                          //NOTE: Still need to allow for editing article
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //function to convert Timestamp to DateTime
  DateTime convertTimestampToDateTime(Timestamp time) {
    return DateTime.fromMillisecondsSinceEpoch(time.millisecondsSinceEpoch);
  }

  //function to format date
  String formatDate(DateTime date) {
    return DateFormat.yMMMMd('en_US').format(date);
  }

  Widget addPadding(Widget item) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: item,
    );
  }
}
