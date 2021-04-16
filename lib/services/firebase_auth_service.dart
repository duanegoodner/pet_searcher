import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

class FirebaseAuthService {
  final _firebaseAuth = fb_auth.FirebaseAuth.instance;

  Future<fb_auth.User> createFirebaseUser(String email, String password) async {
    fb_auth.UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

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
