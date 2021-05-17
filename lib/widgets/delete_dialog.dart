import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Reference: https://api.flutter.dev/flutter/material/AlertDialog-class.html
Future<void> showMyDialog(
    String collectionName, var collectionObject, BuildContext context) async {
  String titleText;
  String bodyText;
  String id;

  //check if item is an animal
  if (collectionName == 'animals') {
    titleText = 'Delete this animal?';
    bodyText =
        'Would you like to permanently remove this animal from the animal inventory?';
    id = '${collectionObject.animalID}';
  }
  //check if item is a newsPost
  else if (collectionName == 'newsPost') {
    titleText = 'Delete this news post?';
    bodyText =
        'Would you like to permanently remove this post from the news feed?';
    id = '${collectionObject.docID}';
  } else {
    print('Error. This collection does not exist.');
  }

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titleText),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text(bodyText),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              FirebaseFirestore.instance
                  .collection('$collectionName')
                  .doc(id)
                  .delete();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
