import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import 'firebase_auth_service.dart';

import '../models/app_user.dart';

class AppUserService {
  final cf.CollectionReference _users =
      cf.FirebaseFirestore.instance.collection('users');
  final fb_auth.User firebaseUser;

  AppUserService({this.firebaseUser});

  Future<AppUser> getCurrentAppUser() async {
    if (firebaseUser == null) {
      return null;
    }
    cf.DocumentSnapshot _appUser = await _users.doc(firebaseUser.uid).get();
    return AppUser.fromJSON(_appUser.data());
  }

  // Future<AppUser> getCurrentAppUser

}
