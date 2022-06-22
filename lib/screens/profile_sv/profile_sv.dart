import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/screens/profile/profile_screen.dart';
import 'package:edulab/screens/profile_sv/profile_sv_screen.dart';
import 'package:flutter/material.dart';

class ProfileSv extends StatefulWidget {
  final String uid;
  const ProfileSv({required this.uid, Key? key}) : super(key: key);

  @override
  State<ProfileSv> createState() => _ProfileSvState();
}

class _ProfileSvState extends State<ProfileSv> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: ProfileSvScreen(
        uid: widget.uid,
      ),
    );
  }
}
