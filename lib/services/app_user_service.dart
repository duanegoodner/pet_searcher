import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import './new_app_user_dto.dart';

import '../models/app_user.dart';

class AppUserService {
  final cf.CollectionReference _users =
      cf.FirebaseFirestore.instance.collection('users');
  final fb_auth.User firebaseUser;

  AppUserService({this.firebaseUser});

  Future<void> uploadNewUser(NewAppUserDTO newAppUserData, String uid) async {
    await _users.doc(uid).set(newAppUserData.toJson());
  }

  Future<AppUser> getCurrentAppUser() async {
    if (firebaseUser == null) {
      return null;
    }
    cf.DocumentSnapshot _appUser = await _users.doc(firebaseUser.uid).get();
    return AppUser.fromJSON(_appUser.data());
  }

  // Future<AppUser> getCurrentAppUser

}
