import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_matcher/screens/add_news_item_screen.dart';
import 'package:share/share.dart';
import 'package:pet_matcher/models/news_item.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = 'newsScreen';

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    String userType = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('News Feed'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: getDrawerType(userType),
      backgroundColor: Colors.blue[300],
      body: buildListFromStream(context, userType),
    );
  }

  //function returning user or admin drawer
  Widget getDrawerType(userType) {
    if (userType == 'admin') {
      return AdminDrawer();
    } else {
      return UserDrawer();
    }
  }

  Widget buildListFromStream(BuildContext context, String userType) {
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
                itemBuilder: (context, index) => _buildNewsItem(
                    context, snapshot.data.docs[index], userType),
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

  Widget _buildNewsItem(
      BuildContext context, DocumentSnapshot document, String userType) {
    DateTime date = convertTimestampToDateTime(document['date']);
    String documentID = document.id;
    //print('The document ID is: $documentID');

    NewsItem post = NewsItem.fromMap({
      'docID': documentID,
      'date': date,
      'imageUrl': document['imageUrl'],
      'title': document['title'],
      'body': document['body'],
    });

    return newsCard(post, userType);
  }

  Widget newsCard(NewsItem post, String userType) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 275,
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(child: Image.network('${post.imageUrl}')),
            ListTile(
                title: addPadding(
                  Text(
                    '${post.title}',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                ),
                subtitle: addPadding(
                  Text(
                    '${post.body}',
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
                      '${formatDate(post.date)}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  articleIconLayout(userType, post)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget articleIconLayout(String userType, NewsItem post) {
    if (userType == 'admin') {
      return Row(
        children: [
          favoriteIcon(),
          shareIcon(post),
          editIcon(post),
        ],
      );
    } else {
      return Row(
        children: [
          favoriteIcon(),
          shareIcon(post),
        ],
      );
    }
  }

  Widget favoriteIcon() {
    return IconButton(
      icon: Icon(Icons.favorite_border_outlined),
      onPressed: () {
        //NOTE: Still need to allow for selecting favorites
        //and adding to favorite screen if we want to do that
      },
    );
  }

  Widget shareIcon(NewsItem post) {
    return IconButton(
      icon: Icon(Icons.share_outlined),
      onPressed: () {
        Share.share(
            'Check out this article from Pet Matcher!\n\n${post.body} ' +
                '\n\n${post.date}.',
            subject: '${post.title}');
      },
    );
  }

  Widget editIcon(NewsItem post) {
    return IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () {
        Navigator.of(context)
            .pushNamed(AddNewsItemScreen.routeName, arguments: post);
      },
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
