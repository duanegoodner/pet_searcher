import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:stream_transform/stream_transform.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/services/new_app_user_dto.dart';

class AppUserService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  final FirebaseAuth firebaseAuth;

  AppUserService({this.firebaseAuth});

  Future<void> uploadNewUser(AppUser newAppUserData, String uid) async {
    await _users.doc(uid).set(newAppUserData.toJson());
  }

  Future<AppUser> getAppUser(String uid) async {
    if (uid == null) {
      return AppUser.initial();
    }
    DocumentSnapshot _userData = await _users.doc(uid).get();
    return AppUser.fromJSON(_userData.data());
  }

  Future<AppUser> appUserSnapshot() async {
    if (firebaseAuth.currentUser == null) {
      return null;
    }
    DocumentSnapshot _appUser =
        await _users.doc(firebaseAuth.currentUser.uid).get();
    return AppUser.fromJSON(_appUser.data());
  }

  Stream<AppUser> get appUserAuthStateChange {
    return firebaseAuth.authStateChanges().asyncMap((e) async {
      if (e == null) {
        return AppUser.initial();
      }
      DocumentSnapshot appUserData = await _users.doc(e.uid).get();
      return AppUser.fromJSON(appUserData.data());
    });
  }

  // Stream<AppUser> get authOrDataChange {
  //   return Rx.combineLatest2(
  //       firebaseAuth.authStateChanges(), _users.doc(firebaseAuth.authStateChanges().uid),
  //       (User auth, QuerySnapshot allUsersData) {
  //     if (auth == null) {
  //       return AppUser.initial();
  //     }
  //     DocumentSnapshot userData =

  //   });
  // }

  Stream<AppUser> get appUserDataChange {
    return userDataStream.map((e) {
      if (e == null) {
        return AppUser.initial();
      }
      return AppUser.fromJSON(e.data());
    });
  }

  Stream<DocumentSnapshot> get userDataStream {
    return _users.doc(firebaseAuth.currentUser?.uid).snapshots();
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

  // Stream<AppUser> get authOrDataChange {
  //   return Rx.combineLatest2(firebaseAuth.authStateChanges(), userDataStream,
  //       (User firebaseUser, DocumentSnapshot appUserData) {
  //     if (firebaseUser == null || appUserData == null) {
  //       return AppUser.initial();
  //     }
  //     return AppUser.fromJSON(appUserData.data());
  //   });
  // }

  // Stream<AppUser> get currentAppUser async* {
  //   AppUser appUser = await appUserSnapshot();
  //   yield appUser;
  // }

  // Future<AppUser> appUserSnapshot

}
