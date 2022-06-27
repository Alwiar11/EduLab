import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/home.dart';
import 'package:edulab/resources/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Waiting extends StatefulWidget {
  final String userId;
  // final DocumentReference<Object?> docRef;
  const Waiting({required this.userId, Key? key}) : super(key: key);

  @override
  State<Waiting> createState() => _WaitingState();
}

class _WaitingState extends State<Waiting> {
  @override
  Widget build(BuildContext context) {
    print(widget.userId);

    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .snapshots(),
      builder: (context, snapshot) {
        UserModel users = UserModel.fromData(snapshot.data!);
        if (snapshot.hasData) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Silahkan Tunggu Hingga Admin Memberikan Izin"),
                Text("Silahkan Refresh Secara Berkala"),
                ElevatedButton(
                  onPressed: () {
                    if (users.isVerified == true) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Home()),
                          (Route<dynamic> route) => false);
                    } else {
                      null;
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: primaryColor),
                  child: Text('Refresh'),
                ),
              ],
            ),
          );
        }
        return CircularProgressIndicator();
      },
    ));
  }
}
