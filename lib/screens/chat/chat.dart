import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/chat/card_chat.dart';

import 'package:edulab/screens/chat/contact/contact.dart';
import 'package:edulab/screens/chat/roomchat/roomchat.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Chat extends StatefulWidget {
  final String? receiver;
  const Chat({this.receiver, Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  String formattedDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat(' hh:mm ').format(dateFromTimeStamp);
  }

  String from = 'chat';
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Pesan",
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => Contact())));
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                ))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .where('participants', arrayContains: uid)
              .orderBy('lastChat', descending: true)
              .snapshots(),
          builder: (_, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                itemCount: snapshots.data!.size,
                itemBuilder: (_, index) {
                  String friendId =
                      snapshots.data!.docs[index].get('participants')[0] == uid
                          ? snapshots.data!.docs[index].get('participants')[1]
                          : snapshots.data!.docs[index].get('participants')[0];
                  return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(friendId)
                          .snapshots(),
                      builder: (context, friendData) {
                        if (!friendData.hasData) {
                          return Container();
                        }
                        return StreamBuilder<
                                QuerySnapshot<Map<String, dynamic>>>(
                            stream: snapshots.data!.docs[index].reference
                                .collection('messages')
                                .orderBy('sendAt', descending: false)
                                .snapshots(),
                            builder: (_, chatData) {
                              if (chatData.hasData) {
                                if (chatData.data!.docs.length > 0) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          FirebaseFirestore.instance
                                              .collection("chats")
                                              .where('participants',
                                                  arrayContains: uid)
                                              .get()
                                              .then((doc) {
                                            print(doc.docs.length);

                                            for (var i = 0; i < doc.size; i++) {
                                              if (doc.docs[i]
                                                  .data()['participants']
                                                  .toString()
                                                  .contains(friendId)) {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RoomChat(
                                                              chatRef: doc
                                                                  .docs[i]
                                                                  .reference,
                                                              name: friendData
                                                                  .data!
                                                                  .get('name'),
                                                              profile: friendData
                                                                  .data!
                                                                  .get(
                                                                      'profile'),
                                                              uid: friendId,
                                                              from: from,
                                                              role: friendData
                                                                  .data!
                                                                  .get('role'),
                                                            )));

                                                break;
                                              }
                                            }
                                          });
                                        },
                                        child: CardChat(
                                          name: friendData.data!.get('name'),
                                          profile:
                                              friendData.data!.get('profile'),
                                          lastChat: chatData.data!.docs.last
                                              .get('message'),
                                          lastTime: formattedDate(chatData
                                              .data!.docs.last
                                              .get('sendAt')),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                      color: primaryColor,
                                      strokeWidth: 10,
                                    ),
                                  ],
                                ),
                              );
                            });
                      });
                },
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: primaryColor,
                    strokeWidth: 10,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
