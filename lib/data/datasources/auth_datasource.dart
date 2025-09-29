import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

import '../constants.dart';
import '../model/user_model.dart';

class AuthDatasource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthDatasource({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
       _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  Stream<UserModel?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser != null
          ? UserModel.fromFirebaseUser(firebaseUser)
          : null;
    });
  }

  Future<UserModel?> checkUserInformation() async {
    final firebase_auth.User? firebaseUser = _firebaseAuth.currentUser;
    return firebaseUser != null
        ? UserModel.fromFirebaseUser(firebaseUser)
        : null;
  }

  Future<UserModel?> loginWithEmail(String email, String password) async {
    if (email.isEmpty) {
      throw Exception('error_empty_email');
    }

    if (password.isEmpty) {
      throw Exception('error_empty_password');
    }

    final firebase_auth.UserCredential credential = await firebase_auth
        .FirebaseAuth
        .instance
        .signInWithEmailAndPassword(email: email, password: password);
    return credential.user != null
        ? UserModel.fromFirebaseUser(credential.user!)
        : null;
  }

  Future<UserModel?> loginWithGoogle() async {
    _googleSignIn.initialize(serverClientId: kServerClientId);
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;
    final firebase_auth.OAuthCredential credential = firebase_auth
        .GoogleAuthProvider.credential(idToken: googleAuth.idToken);
    firebase_auth.UserCredential userCredential = await firebase_auth
        .FirebaseAuth
        .instance
        .signInWithCredential(credential);

    return userCredential.user != null
        ? UserModel.fromFirebaseUser(userCredential.user!)
        : null;
  }

  Future<UserModel?> signupWithEmail(String email, String password) async {
    final firebase_auth.UserCredential credential = await firebase_auth
        .FirebaseAuth
        .instance
        .createUserWithEmailAndPassword(email: email, password: password);

    return credential.user != null
        ? UserModel.fromFirebaseUser(credential.user!)
        : null;
  }

  Future<void> sendEmailVerification() async {
    await _firebaseAuth.currentUser?.sendEmailVerification();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> logout() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }
}
