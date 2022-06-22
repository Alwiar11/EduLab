import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/screens/profile/profile_screen.dart';
import 'package:edulab/screens/profile_pkl/profile_pkl_screen.dart';
import 'package:edulab/screens/profile_sv/profile_sv_screen.dart';
import 'package:flutter/material.dart';

class ProfilePkl extends StatefulWidget {
  final String uid;
  const ProfilePkl({required this.uid, Key? key}) : super(key: key);

  @override
  State<ProfilePkl> createState() => _ProfilePklState();
}

class _ProfilePklState extends State<ProfilePkl> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: ProfilePklScreen(
        uid: widget.uid,
      ),
    );
  }
}
