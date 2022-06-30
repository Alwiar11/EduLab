import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/class/add_reply.dart';
import 'package:edulab/screens/class/reply_room.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Reply extends StatefulWidget {
  final DocumentReference<Map<String, dynamic>> docRefReply;
  const Reply({required this.docRefReply, Key? key}) : super(key: key);

  @override
  State<Reply> createState() => _ReplyState();
}

class _ReplyState extends State<Reply> {
  String? role;
  String? uid;
  @override
  void initState() {
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');
    uid = prefs.getString('uid');
    setState(() {});
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
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        title: Text(
          'Lihat Jawaban',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: role == 'supervisor'
            ? widget.docRefReply.collection('reply').snapshots()
            : widget.docRefReply.collection('reply').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                SizedBox(
                  height: 10,
                ),
                ...snapshot.data!.docs.map((e) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        onTap: () {
                          final snackBar = SnackBar(
                              content:
                                  Text('Tidak Bisa Melihat Tugas Orang Lain'));
                          role == 'supervisor' || e.get('senderId') == uid
                              ? Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ReplyRoom(
                                        docRefReply: widget.docRefReply,
                                        replyId: e.id,
                                      )))
                              : ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          height: 80,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                e.get('senderName'),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                role != 'supervisor'
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  AddReply(docRefReply: widget.docRefReply)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: primaryColor),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
