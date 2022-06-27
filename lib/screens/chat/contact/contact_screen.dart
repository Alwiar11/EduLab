import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edulab/screens/chat/roomchat/roomchat.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'card_contact.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  String? uid;
  String from = 'contact';

  @override
  void initState() {
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  padding: EdgeInsets.symmetric(vertical: 5),
                  width: Constant(context).width * 0.9,
                  height: Constant(context).height * 0.05,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 2),
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 10),
                        hintText: 'Cari...',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection("users").snapshots(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        ...snapshot.data!.docs
                            .where((element) => element.reference.id != uid)
                            .map((e) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: InkWell(
                                    onTap: () async {
                                      FirebaseFirestore.instance
                                          .collection("chats")
                                          .where('participants',
                                              arrayContains: uid)
                                          .get()
                                          .then((doc) async {
                                        print(doc.docs.length);
                                        bool ada = false;

                                        for (var i = 0; i < doc.size; i++) {
                                          if (doc.docs[i]
                                              .data()['participants']
                                              .toString()
                                              .contains(e.id)) {
                                            ada = true;

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RoomChat(
                                                          chatRef: doc.docs[i]
                                                              .reference,
                                                          name: e.get('name'),
                                                          profile:
                                                              e.get('profile'),
                                                          uid: e.id,
                                                          from: from,
                                                          role: e.get('role'),
                                                        )));
                                            break;
                                          }
                                        }
                                        if (!ada) {
                                          DocumentReference<
                                                  Map<String, dynamic>> docRef =
                                              await FirebaseFirestore.instance
                                                  .collection("chats")
                                                  .add({
                                            'createdAt': Timestamp.now(),
                                            'isDeleted': {
                                              uid: false,
                                              e.id: false,
                                            },
                                            'participants':
                                                FieldValue.arrayUnion(
                                                    [uid, e.id]),
                                          });
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RoomChat(
                                                        name: e.get('name'),
                                                        chatRef: docRef,
                                                        profile:
                                                            e.get('profile'),
                                                        uid: e.id,
                                                        from: from,
                                                        role: e.get('role'),
                                                      )));
                                        }
                                      });
                                    },
                                    child: CardContact(
                                      name: e.get('name'),
                                      profile: e.get("profile"),
                                      uid: e.id,
                                    ),
                                  ),
                                ))
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                })
          ],
        ),
      ),
    );
  }
}