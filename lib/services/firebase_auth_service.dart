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

  Stream<fb_auth.User> get authStateChange {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> firebaseSignOut() async {
    _firebaseAuth.signOut();
  }

  bool get isUserSignedIn {
    return _firebaseAuth.currentUser != null;
  }

  fb_auth.User get currentUser {
    return _firebaseAuth.currentUser;
  }
}
