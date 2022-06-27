import 'package:cloud_firestore/cloud_firestore.dart';
import 'profile_user_admin_screen.dart';
import 'package:flutter/material.dart';

class ProfileUserAdminSv extends StatefulWidget {
  final String uid;
  const ProfileUserAdminSv({required this.uid, Key? key}) : super(key: key);

  @override
  State<ProfileUserAdminSv> createState() => _ProfileUserAdminSvState();
}

class _ProfileUserAdminSvState extends State<ProfileUserAdminSv> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: ProfileUserAdminSvScreen(
        uid: widget.uid,
      ),
    );
  }
}
