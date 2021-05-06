import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_matcher/models/news_item.dart';
import 'package:pet_matcher/screens/admin_home_screen.dart';
import 'package:pet_matcher/services/image_service.dart';
import 'package:pet_matcher/widgets/elevated_button.dart';
import 'package:pet_matcher/widgets/standard_input_box.dart';

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
    newNewsPost.date = DateTime.now();
    print('$newNewsPost.date');
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        centerTitle: true,
        title: Text('Add News Post'),
        backgroundColor: Colors.blue[300],
      ),
      backgroundColor: Colors.blue[300],
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              titleField(context),
              bodyField(context),
              Padding(
                padding: EdgeInsets.only(left: 20), 
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, 
                  children: [
                    addImageFAB(context),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: addFABLabelText(context, fabLabel),
                    ),
                  ]
                ),
              ),
              postArticleButton(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget titleField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'Title',
        validatorPrompt: 'Enter the title.',
        validatorCondition: (value) => value.isEmpty,
        onSaved: (value) {
          newNewsPost.title = value;
        });
  }

  Widget bodyField(BuildContext context) {
    return standardInputBoxWithoutFlex(
        labelText: 'Post',
        validatorPrompt: 'Enter the post text.',
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
    fabLabel = 'Got it!';
    newNewsPost.imageUrl = imageUrl;
    setState(() {});
  }

  Widget addFABLabelText(BuildContext context, String text) {
    return Text('$text', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold));
  }

  Widget postArticleButton(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(10),
        child: elevatedButtonStandard('Submit', createNewsItem));
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
}
