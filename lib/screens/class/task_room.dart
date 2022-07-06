import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:edulab/screens/class/reply.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskRoom extends StatefulWidget {
  final CollectionReference<Map<String, dynamic>>? collRefTaskRoom;
  final String? taskRoomId;
  const TaskRoom({this.collRefTaskRoom, this.taskRoomId, Key? key})
      : super(key: key);

  @override
  State<TaskRoom> createState() => _TaskRoomState();
}

class _TaskRoomState extends State<TaskRoom> {
  String? role;
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');
    uid = prefs.getString('uid');
    setState(() {});
  }

  String formattedDate(Timestamp timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat(' EEE d MMM y').format(dateFromTimeStamp);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.collRefTaskRoom);
    print(widget.taskRoomId);
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
          "Tugas",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream: widget.collRefTaskRoom!.doc(widget.taskRoomId).snapshots(),
          builder: (_, snapshots) {
            if (snapshots.hasData) {
              print(snapshots.data!.get('endedAt'));
              DocumentReference<Map<String, dynamic>> docRefReply =
                  widget.collRefTaskRoom!.doc(widget.taskRoomId);
              return Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 10, left: 30),
                              child: Text(
                                'Masa Tenggat :' +
                                    formattedDate(
                                        snapshots.data!.get('endedAt')),
                                style: TextStyle(fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 20, left: 30),
                              child: Text(
                                snapshots.data!.get('title'),
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Row(
                                children: [
                                  // Icon(
                                  //   Icons.label_important_outline_rounded,
                                  //   size: 20,
                                  // ),
                                  Expanded(
                                    child: Text(
                                      snapshots.data!.get('subtitle'),
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 86, 86, 86)),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onVerticalDragDown: (_) {
                        role != 'supervisor'
                            ? Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Reply(
                                    docRefReply: docRefReply,
                                  ),
                                ),
                              )
                            : Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => Reply(
                                    docRefReply: docRefReply,
                                  ),
                                ),
                              );
                      },
                      // onTap: () {
                      //   role != 'supervisor'
                      //       ? Navigator.of(context).push(
                      //           MaterialPageRoute(
                      //             builder: (context) => Reply(
                      //               docRefReply: docRefReply,
                      //             ),
                      //           ),
                      //         )
                      //       : Navigator.of(context).push(
                      //           MaterialPageRoute(
                      //             builder: (context) => Reply(
                      //               docRefReply: docRefReply,
                      //             ),
                      //           ),
                      //         );
                      // },
                      child: Container(
                        color: Colors.white,
                        height: 70,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.keyboard_arrow_up,
                                    size: 30,
                                  ),
                                  Text(
                                    "Lihat Jawaban",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
