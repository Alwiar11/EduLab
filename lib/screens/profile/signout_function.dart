import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login/login.dart';

class SignOut {
  final BuildContext context;
  SignOut(this.context);
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> signout() async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginPage()),
            (route) => false));
  }
}
