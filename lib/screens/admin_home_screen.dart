import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:pet_matcher/locator.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/news_item.dart';
import 'package:pet_matcher/services/animal_service.dart';
import 'package:pet_matcher/screens/add_news_item_screen.dart';
import 'package:pet_matcher/widgets/admin_drawer.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';

class AdminHomeScreen extends StatefulWidget {
  static const routeName = 'adminHome';

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Admin'),
        backgroundColor: Colors.blue[300],
      ),
      drawer: AdminDrawer(),
      backgroundColor: Colors.blue[300],
      body: SingleChildScrollView(
        child: Column(
          children: [
            headingText('News Feed:'),
            buildListFromStream(context),
            //addNewsItemButton(),
            headingText('Manage Inventory:'),
            inventoryCard(),
            headingText('Featured Animals:'),
            buildFeaturedAnimalsCard(context),
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
                height: 320,
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


  Widget addNewsItemButton() {
    return elevatedButtonStandard('Add News Post', () {
      Navigator.of(context).pushNamed(AddNewsItemScreen.routeName);
    });
  }

  Widget inventoryCard() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: 275,
      height: 265,
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
                child: Wrap(children: <Widget>[
              Image.asset('assets/images/frenchie_in_costume.jpg',
                  height: 200, width: 275, fit: BoxFit.fitWidth),
            ])),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    //Animal inventory page?
                  },
                ),
              ],
            ),
          ],
        ),
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
            Container(
              child: Card(
                  child: Wrap(children: <Widget>[
                    Image.network(animal.imageURL,
                        height: 165, width: 275, fit: BoxFit.fitHeight),
                  ])),
            ),
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
                Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      //Animal inventory page?
                    },
                  ),
                ),
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

  Widget editIcon() {
    return  IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () {
        //NOTE: Still need to allow for editing article
      },
    );
  }

  Widget articleIconLayout(NewsItem post) {
    return Row(
      children: [
        editNewsIcon(post),
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

  Widget editNewsIcon(NewsItem post) {
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
