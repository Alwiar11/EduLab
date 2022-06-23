import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/screens/profile/profile_screen.dart';
import 'package:edulab/screens/profile_user/profile_user_screen.dart';

import 'package:flutter/material.dart';

class ProfileUser extends StatefulWidget {
  final String uid;
  const ProfileUser({required this.uid, Key? key}) : super(key: key);

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: ProfileUserScreen(
        uid: widget.uid,
      ),
    );
  }
}
