import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginViewModel extends ChangeNotifier {
  String message = "";
  Future<bool> login() async {
    var userCredential;

    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      message = e.toString();
    }

    return userCredential != null;
  }

  User get user => FirebaseAuth.instance.currentUser;
}
