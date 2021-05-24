import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pet_matcher/models/animal.dart';
import 'package:pet_matcher/models/app_user.dart';
import 'package:pet_matcher/models/user_favorites.dart';
import 'package:pet_matcher/services/new_app_user_dto.dart';

class AppUserService {
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');

  final FirebaseAuth firebaseAuth;

  AppUserService({this.firebaseAuth});

  Future<void> uploadNewUser(NewAppUserDTO newAppUserData, String uid) async {
    await _users.doc(uid).set(newAppUserData.toJson());
  }

  Future<void> createNewUser(
      {String email, String password, NewAppUserDTO newAppUserData}) async {
    UserCredential newUserCredential = await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    User newFirebaseUser = newUserCredential.user;
    newAppUserData.email = newFirebaseUser.email;
    await uploadNewUser(newAppUserData, newFirebaseUser.uid);
  }

  Future<AppUser> appUserSnapshot() async {
    if (firebaseAuth.currentUser == null) {
      return null;
    }
    DocumentSnapshot _appUser =
        await _users.doc(firebaseAuth.currentUser.uid).get();
    return AppUser.fromJSON(_appUser.data());
  }

  Future<String> get userRole async {
    AppUser appUser = await appUserSnapshot();
    String userRole = appUser?.role;
    userRole ??= 'unknown';
    return userRole;
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

  Stream<UserFavorites> favoritesOnDataChange() {
    return _users.doc(firebaseAuth.currentUser.uid).snapshots().map((userDoc) {
      if (userDoc == null) {
        return UserFavorites.initial();
      }
      return UserFavorites.fromJSON(userDoc.data());
    });
  }

  void addToFavorites(Animal animal) {
    _users.doc(firebaseAuth.currentUser.uid).update({
      'favorites': FieldValue.arrayUnion([animal.animalID])
    });
  }

  void removeFromFavorites(Animal animal) {
    _users.doc(firebaseAuth.currentUser.uid).update({
      'favorites': FieldValue.arrayRemove([animal.animalID])
    });
  }

  void updateFavorites(Animal animal, UserFavorites userFavorites) {
    if (userFavorites.favorites.contains(animal.animalID)) {
      removeFromFavorites(animal);
    } else {
      addToFavorites(animal);
    }
  }

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

  Future<void> signIn({String email, String password}) async {
    await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // Stream<AppUser> get currentAppUser async* {
  //   AppUser appUser = await appUserSnapshot();
  //   yield appUser;
  // }

  Future<AppUser> getAppUser(String uid) async {
    if (uid == null) {
      return AppUser.initial();
    }
    DocumentSnapshot _userData = await _users.doc(uid).get();
    return AppUser.fromJSON(_userData.data());
  }
}
