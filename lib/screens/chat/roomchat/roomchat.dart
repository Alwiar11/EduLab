import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/chat/chat.dart';
import 'package:edulab/screens/profile_user/profile_user.dart';

import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';

class RoomChat extends StatefulWidget {
  final DocumentReference<Map<String, dynamic>> chatRef;
  final String profile;
  final String name;
  final String uid;
  RoomChat(
      {required this.name,
      required this.uid,
      required this.profile,
      required this.chatRef,
      Key? key})
      : super(key: key);

  @override
  State<RoomChat> createState() => _RoomChatState();
}

class _RoomChatState extends State<RoomChat> {
  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        toolbarHeight: 70,
        title: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: widget.profile != ""
                    ? DecorationImage(
                        image: NetworkImage(widget.profile), fit: BoxFit.cover)
                    : DecorationImage(
                        image: AssetImage("assets/images/default.png"),
                        fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.name,
                    style: TextStyle(color: Colors.black),
                  )),
            ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileUser(uid: widget.uid)));
                },
                icon: Icon(
                  Icons.more_vert_outlined,
                  color: Colors.black,
                ))
          ],
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: widget.chatRef
              .collection("messages")
              .orderBy('sendAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SizedBox();
            }
            return Container(
              margin: EdgeInsets.only(bottom: 70),
              child: ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.size,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 10, bottom: 10),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        left: 14, right: 14, top: 10, bottom: 10),
                    child: Align(
                      alignment: (snapshot.data!.docs[index]['receiverId'] ==
                              widget.uid
                          ? Alignment.topRight
                          : Alignment.topLeft),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: (snapshot.data!.docs[index]['receiverId'] ==
                                  widget.uid
                              ? secondaryColor
                              : Color.fromARGB(255, 255, 255, 255)),
                        ),
                        padding: EdgeInsets.all(16),
                        child: Text(
                          snapshot.data!.docs[index]['message'],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
      bottomSheet: Container(
        padding: EdgeInsets.only(left: 10, bottom: 10, top: 10, right: 10),
        // height: 60,
        width: double.infinity,
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: TextField(
                controller: messageController,
                decoration: InputDecoration(
                    hintText: "Tulis Pesan...",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            FloatingActionButton(
              onPressed: () {
                widget.chatRef.collection('messages').add({
                  'message': messageController.text,
                  'receiverId': widget.uid,
                  'sendAt': Timestamp.now()
                });
                messageController.clear();
              },
              child: Icon(
                Icons.send,
                color: Colors.white,
                size: 18,
              ),
              backgroundColor: primaryColor,
              elevation: 0,
            ),
          ],
        ),
      ),
    );
  }
}
