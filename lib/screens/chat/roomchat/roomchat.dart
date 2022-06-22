import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/chat/roomchat/roomchat_screen.dart';
import 'package:flutter/material.dart';

class RoomChat extends StatelessWidget {
  final String profile;
  final String name;
  final String uid;
  const RoomChat(
      {required this.name, required this.uid, required this.profile, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: profile != ""
                    ? DecorationImage(
                        image: NetworkImage(profile), fit: BoxFit.cover)
                    : DecorationImage(
                        image: AssetImage("assets/images/default.png"),
                        fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(name)),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
          ],
        ),
        backgroundColor: primaryColor,
      ),
      body: RoomChatScreen(),
    );
  }
}
