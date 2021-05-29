import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_matcher/widgets/delete_dialog.dart';
import 'package:provider/provider.dart';
import 'package:pet_matcher/screens/add_news_item_screen.dart';
import 'package:share/share.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/models/news_item.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';

import '../styles.dart';

class NewsScreen extends StatefulWidget {
  static const routeName = 'newsScreen';

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    String userType = Provider.of<AppUser>(context).role;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('News Feed'),
        backgroundColor: Styles.appBarColor,
      ),
      drawer: getDrawerType(userType),
      backgroundColor: Styles.backgroundColor,
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
            Container(
                child: CachedNetworkImage(
              imageUrl: post.imageUrl,
            )),
            ListTile(
                title: addPadding(
                  Text(
                    '${post.title}',
                    textAlign: TextAlign.left,
                    style: Styles.newsFeedTitleText,
                  ),
                ),
                subtitle: addPadding(
                  Text(
                    '${post.body}',
                    textAlign: TextAlign.left,
                    style: Styles.newsFeedBodyText,
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
                      style: Styles.newsFeedDateText,
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
          shareIcon(post),
          editIcon(post),
          deleteIcon(post, context),
        ],
      );
    } else {
      return Row(
        children: [
          shareIcon(post),
        ],
      );
    }
  }

  Widget deleteIcon(NewsItem post, BuildContext context) {
    return IconButton(
        icon: Icon(Icons.delete),
        tooltip: 'Remove post',
        onPressed: () {
          showMyDialog('newsPost', post, context);
        });
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
