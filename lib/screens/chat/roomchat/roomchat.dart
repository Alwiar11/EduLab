import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';

import 'package:edulab/screens/profile_user/profile_user.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../shared/image_picker.dart';

class RoomChat extends StatefulWidget {
  final DocumentReference<Map<String, dynamic>>? chatRef;
  final String profile;
  final String name;
  final String uid;
  final String from;
  final String role;

  RoomChat(
      {required this.name,
      required this.uid,
      required this.profile,
      this.chatRef,
      required this.from,
      required this.role,
      Key? key})
      : super(key: key);

  @override
  State<RoomChat> createState() => _RoomChatState();
}

class _RoomChatState extends State<RoomChat> {
  String getImageName(XFile image) {
    return image.path.split('/').last;
  }

  Future<DocumentReference<Map<String, dynamic>>>? chatId;
  String formattedDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat(' hh:mm ').format(dateFromTimeStamp);
  }

  TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String chatRef = widget.chatRef!.id;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              if (widget.from == 'contact') {
                Navigator.of(context)
                  ..pop()
                  ..pop();
              } else if (widget.from == 'chat') {
                Navigator.of(context).pop();
              }
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
                          builder: (context) => ProfileUser(
                                uid: widget.uid,
                                role: widget.role,
                              )));
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
              ?.collection("messages")
              .orderBy('sendAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
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
                          left: 14, right: 14, top: 6, bottom: 6),
                      child: Align(
                        alignment: (snapshot.data!.docs[index]['receiverId'] ==
                                widget.uid
                            ? Alignment.topRight
                            : Alignment.topLeft),
                        child: snapshot.data!.docs[index]['type'] == 'text'
                            ? Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (snapshot.data!.docs[index]
                                              ['receiverId'] ==
                                          widget.uid
                                      ? secondaryColor
                                      : Color.fromARGB(255, 255, 255, 255)),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text.rich(TextSpan(
                                    text: snapshot.data!.docs[index]['message']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w400),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '  ' +
                                              formattedDate(snapshot
                                                  .data!.docs[index]['sendAt']),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                  255, 111, 111, 111)))
                                    ])))
                            : Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (snapshot.data!.docs[index]
                                              ['receiverId'] ==
                                          widget.uid
                                      ? secondaryColor
                                      : Color.fromARGB(255, 255, 255, 255)),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.network(
                                      snapshot.data!.docs[index]['image'],
                                      height: 150,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                          formattedDate(snapshot
                                              .data!.docs[index]['sendAt']),
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Color.fromARGB(
                                                  255, 111, 111, 111))),
                                    )
                                  ],
                                )),
                      ),
                    );
                  },
                ),
              );
            }
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
              onTap: () async {
                XFile? image = await AppImagePicker(context).getImageGallery2();

                if (image != null) {
                  FirebaseStorage.instance
                      .ref(
                          'chat/$chatRef/${AppImagePicker(context).getImageName(image)}')
                      .putFile(File(image.path))
                      .then((result) async {
                    String downloadUrl = await result.ref.getDownloadURL();
                    // Simpan downloadUrl di collection user
                    // teapal colletiona soalna
                    chatId = widget.chatRef?.collection('messages').add({
                      'image': downloadUrl,
                      'receiverId': widget.uid,
                      'sendAt': Timestamp.now(),
                      'receivername': widget.name,
                      'type': 'image',
                      'message': ''
                    });
                  });
                }
              },
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
              mini: true,
              onPressed: () {
                if (messageController.text.isNotEmpty) {
                  chatId = widget.chatRef?.collection('messages').add({
                    'message': messageController.text,
                    'receiverId': widget.uid,
                    'sendAt': Timestamp.now(),
                    'receivername': widget.name,
                    'type': 'text'
                  });
                  messageController.clear();
                  widget.chatRef?.update({'lastChat': Timestamp.now()});
                }
                return null;
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
