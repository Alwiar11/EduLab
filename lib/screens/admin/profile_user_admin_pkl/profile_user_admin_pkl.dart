import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edulab/screens/profile_user/profile_user_screen.dart';

import 'package:flutter/material.dart';

import 'profile_user_admin_screen.dart';

class ProfileUserAdminPkl extends StatefulWidget {
  final String uid;
  const ProfileUserAdminPkl({required this.uid, Key? key}) : super(key: key);

  @override
  State<ProfileUserAdminPkl> createState() => _ProfileUserAdminPklState();
}

class _ProfileUserAdminPklState extends State<ProfileUserAdminPkl> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: ProfileUserAdminPklScreen(
        uid: widget.uid,
      ),
    );
  }
}
