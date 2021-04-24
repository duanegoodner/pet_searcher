import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart' as cf;
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/services/new_app_user_dto.dart';

class AppUserService {
  final cf.CollectionReference _users =
      cf.FirebaseFirestore.instance.collection('users');

  final fb_auth.FirebaseAuth firebaseAuth;

  AppUserService({this.firebaseAuth});

  Future<void> uploadNewUser(NewAppUserDTO newAppUserData, String uid) async {
    await _users.doc(uid).set(newAppUserData.toJson());
  }

  Future<AppUser> appUserSnapshot() async {
    if (firebaseAuth.currentUser == null) {
      return null;
    }
    cf.DocumentSnapshot _appUser =
        await _users.doc(firebaseAuth.currentUser.uid).get();
    return AppUser.fromJSON(_appUser.data());
  }

  Stream<AppUser> get appUserAuthStateChange {
    return firebaseAuth.authStateChanges().asyncMap((e) async {
      cf.DocumentSnapshot appUserData = await _users.doc(e.uid).get();
      return AppUser.fromJSON(appUserData.data());
    });
  }

  Future<String> get userRole async {
    AppUser appUser = await appUserSnapshot();
    String userRole = appUser?.role;
    userRole ??= 'unknown';
    return userRole;
  }

  Future<void> signIn({String email, String password}) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Stream<cf.DocumentSnapshot> get userDataStream {
    return _users.doc(firebaseAuth.currentUser.uid).snapshots();
  }

  // Stream<AppUser> get currentAppUser async* {
  //   AppUser appUser = await appUserSnapshot();
  //   yield appUser;
  // }

  // Future<AppUser> appUserSnapshot

}
