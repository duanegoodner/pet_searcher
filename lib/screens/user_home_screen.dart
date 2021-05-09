import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:pet_matcher/locator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pet_matcher/services/animal_service.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/widgets/user_drawer.dart';
import 'package:pet_matcher/models/news_item.dart';

class UserHomeScreen extends StatefulWidget {
  static const routeName = 'userHomeScreen';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Find a Match!'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: UserDrawer(),
      backgroundColor: Colors.blue[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            animalSearch(),
            headingText('View Favorites:'),
            favoritesCard(),
            headingText('Featured Animals:'),
            buildFeaturedAnimalsCard(context),
            headingText('News Feed:'),
            buildListFromStream(context),
            /*Center(
              child: buildListFromStream(context),
            ),*/
          ],
        ),
      ),
    );
  }

  Widget headingText(String heading) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      child: Text(
        '$heading',
        style: TextStyle(
          fontSize: 26,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget animalSearch() {
    return GestureDetector(
      onTap: () {
        //Go to search screen
        print('Going to search!');
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: iconRow(),
      ),
    );
  }

  Widget iconRow() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text('Search',
              style: TextStyle(
                  color: Colors.blue[300],
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0)),
          Icon(FontAwesomeIcons.dog, color: Colors.blue[300], size: 35),
          Icon(FontAwesomeIcons.cat, color: Colors.blue[300], size: 35),
          Icon(FontAwesomeIcons.featherAlt, color: Colors.blue[300], size: 35),
        ]);
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
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) => _buildNewsItem(
                      context, snapshot.data.docs[index]),
                ),
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
      BuildContext context, DocumentSnapshot document) {
    DateTime date = convertTimestampToDateTime(document['date']);

    NewsItem post = NewsItem.fromMap({
      'date': date,
      'imageUrl': document['imageUrl'],
      'title': document['title'],
      'body': document['body'],
    });

    return newsCard(post);
  }

  Widget newsCard(NewsItem post) {
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
                  articleIconLayout(post)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFeaturedAnimalsCard(BuildContext context) {
    Stream animalListStream = locator<AnimalService>().availableAnimalStream();

    return StreamBuilder(
        stream: animalListStream,
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data.length > 0) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                    itemBuilder: (context, index) {
                      Animal animal = snapshot.data[index];
                      return featuredAnimalCard(animal);
                    },
                ),
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

  Widget favoritesCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 275,
      height: 218,
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Stack(children: <Widget>[
            Card(
                child: Wrap(children: <Widget>[
              Image.asset('assets/images/frenchie_in_costume.jpg',
                  height: 200, width: 275, fit: BoxFit.fitWidth),
            ])),
            Padding(
              padding: EdgeInsets.only(top: 5.0, left: 238.0),
              child: Icon(Icons.favorite, color: Colors.red),
            ),
          ]),
        ]),
      ),
    );
  }

  Widget featuredAnimalCard(Animal animal) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 160,
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
                child: Wrap(children: <Widget>[
              Image.network(animal.imageURL,
                  height: 165, width: 275, fit: BoxFit.fitHeight),
            ])),
            Row(
              children: <Widget>[animalCardText(animal.name, 16.0)],
            ),
            Row(
              children: <Widget>[
                animalCardText(animal.type, 14.0),
              ],
            ),
            Row(
              children: <Widget>[
                animalCardText(animal.gender, 14.0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget animalCardText(String animalText, double size) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('$animalText', style: TextStyle(fontSize: size)),
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

  Widget articleIconLayout(NewsItem post) {
    return Row(
      children: [
        favoriteIcon(),
        shareIcon(post),
      ],
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

  Widget favoriteIcon() {
    return IconButton(
      icon: Icon(Icons.favorite_border_outlined),
      onPressed: () {
        //NOTE: Still need to allow for selecting favorites
        //and adding to favorite screen if we want to do that
      },
    );
  }

}

