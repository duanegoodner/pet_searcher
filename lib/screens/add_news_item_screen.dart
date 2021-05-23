import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_matcher/models/news_item.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/services/image_service.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
import 'package:pet_matcher/widgets/standard_input_box.dart';

import '../styles.dart';

class AddNewsItemScreen extends StatefulWidget {
  static const routeName = 'addNewsItemScreen';

  @override
  _AddNewsItemScreenState createState() => _AddNewsItemScreenState();
}

class _AddNewsItemScreenState extends State<AddNewsItemScreen> {
  final formKey = GlobalKey<FormState>();
  NewsItem newNewsPost = NewsItem();
  String fabLabel = 'Select an image to include with your post.';

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    NewsItem receivedNewsItem = ModalRoute.of(context).settings.arguments;
    if (receivedNewsItem != null) {
      newNewsPost.imageUrl = receivedNewsItem.imageUrl;
      newNewsPost.docID = receivedNewsItem.docID;
      fabLabel = 'Image Selected!';
    }
    newNewsPost.date = DateTime.now();
    print('$newNewsPost.date');
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        centerTitle: true,
        title: Text('Add News Post'),
        backgroundColor: Styles.appBarColor,
      ),
      backgroundColor: Styles.backgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              titleField(context, receivedNewsItem),
              bodyField(context, receivedNewsItem),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  addImageFAB(context),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: addFABLabelText(context, fabLabel),
                  ),
                ]),
              ),
              postArticleButton(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget titleField(BuildContext context, NewsItem receivedNewsItem) {
    String initialValue;
    if (receivedNewsItem != null) {
      initialValue = receivedNewsItem.title;
    }
    return standardInputBoxWithoutFlex(
        labelText: 'Title',
        validatorPrompt: 'Enter the title.',
        initialValue: initialValue,
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {
          newNewsPost.title = value;
        });
  }

  Widget bodyField(BuildContext context, NewsItem receivedNewsItem) {
    String initialValue;
    if (receivedNewsItem != null) {
      initialValue = receivedNewsItem.body;
    }
    return standardInputBoxWithoutFlex(
        labelText: 'Post',
        validatorPrompt: 'Enter the post text.',
        initialValue: initialValue,
        alignLabelWithHint: true,
        keyboardType: TextInputType.multiline,
        maxLines: 17,
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {
          newNewsPost.body = value;
        });
  }

  Widget addImageFAB(BuildContext context) {
    String imageUrl;

    return Padding(
        padding: EdgeInsets.only(bottom: 5, top: 5),
        child: FloatingActionButton(
            child: const Icon(Icons.photo_camera_outlined),
            backgroundColor: Colors.grey,
            onPressed: () {
              getImageUrl(imageUrl);
            }));
  }

  void getImageUrl(String imageUrl) async {
    imageUrl = await retrieveImageUrl();
    fabLabel = 'Image Selected!';
    newNewsPost.imageUrl = imageUrl;
    setState(() {});
  }

  Widget addFABLabelText(BuildContext context, String text) {
    return Text('$text', style: Styles.fabText);
  }

  Widget postArticleButton(BuildContext context) {
    //determine if a new post is being added or a previous post is being edited
    if (newNewsPost.docID == null) {
      return Padding(
          padding: EdgeInsets.all(10),
          child: elevatedButtonStandard('Submit', createNewsItem));
    } else {
      return Padding(
          padding: EdgeInsets.all(10),
          child: elevatedButtonStandard('Submit', editNewsItem));
    }
  }

  Future<void> createNewsItem() async {
    if (formKey.currentState.validate()) {
      try {
        //save form
        formKey.currentState.save();
        //add news item to database
        FirebaseFirestore.instance.collection('newsPost').add({
          'title': newNewsPost.title,
          'date': DateTime.parse('${newNewsPost.date}'),
          'body': newNewsPost.body,
          'imageUrl': newNewsPost.imageUrl,
        });
        //navigate back to admin home screen
        Navigator.of(context).pushReplacementNamed(AdminHomeScreen.routeName);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> editNewsItem() async {
    if (formKey.currentState.validate()) {
      try {
        //save form
        formKey.currentState.save();
        //update news item in the database
        FirebaseFirestore.instance
            .collection('newsPost')
            .doc('${newNewsPost.docID}')
            .set({
          'title': newNewsPost.title,
          'date': DateTime.parse('${newNewsPost.date}'),
          'body': newNewsPost.body,
          'imageUrl': newNewsPost.imageUrl,
        });
        //navigate back to admin home screen
        Navigator.of(context).pushReplacementNamed(AdminHomeScreen.routeName);
      } catch (e) {
        print(e);
      }
    }
  }
}
