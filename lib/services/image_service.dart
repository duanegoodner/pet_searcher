import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

//Reference for ImageServices Code: https://dev.to/rrtutors/upload-image-to-firebase-storage-flutter-android-ios-3f35
Future<String> retrieveImageUrl() async {
  final picker = ImagePicker();
  String imageUrl = "";
  try {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    print("Picked File Path: " + pickedFile.path);
    File image = File(pickedFile.path);
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('Pet-image-' + DateTime.now().toString() + '.jpg');
    UploadTask uploadTask = storageReference.putFile(image);
    await uploadTask;
    imageUrl = await storageReference.getDownloadURL();
  } catch (e) {
    print("Access denied ${e.toString()}");
  }

  return imageUrl;
}
