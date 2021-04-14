import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../models/app_user.dart';

class FirebaseAuthService {
  final _firebaseAuth = fb_auth.FirebaseAuth.instance;
  final cf.CollectionReference _users =
      cf.FirebaseFirestore.instance.collection('users');

  Future<fb_auth.User> firebaseSignIn(String email, String password) async {
    fb_auth.UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  Future<AppUser> getAppUser(fb_auth.User user) async {
    if (user == null) {
      return null;
    }
    cf.DocumentSnapshot _appUser = await _users.doc(user.uid).get();

    return AppUser.fromJSON(_appUser.data());
  }
}
