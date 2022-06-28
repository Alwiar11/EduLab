import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/class/add_class_participants.dart';
import 'package:edulab/screens/class/add_task.dart';
import 'package:edulab/screens/class/card_task.dart';
import 'package:edulab/screens/class/task_room.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/constant.dart';

class Class extends StatefulWidget {
  final String? classId;
  final DocumentReference<Map<String, dynamic>>? docRef;
  const Class({this.classId, this.docRef, Key? key}) : super(key: key);

  @override
  State<Class> createState() => _ClassState();
}

class _ClassState extends State<Class> {
  String formattedDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat(' EEE d MMM ').format(dateFromTimeStamp);
  }

  String? role;
  String? uid;
  String? classIdPkl;

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

  @override
  Widget build(BuildContext context) {
    print(widget.docRef);
    print(widget.classId);
    return Scaffold(
        appBar: role == 'supervisor'
            ? AppBar(
                backgroundColor: primaryColor,
                elevation: 0,
                title: Text('Kelas'),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddClassParticpants(
                                    classId: widget.classId ?? '',
                                    docRef: widget.docRef,
                                  )));
                        },
                        icon: Icon(
                          Icons.add,
                          size: 25,
                        )),
                  )
                ],
              )
            : null,
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('class')
                .where('participants', arrayContains: uid)
                .limit(1)
                .snapshots(),
            builder: (_, snapshots) {
              if (snapshots.hasData) {
                return SafeArea(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(
                            height: Constant(context).width * 0.02,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            width: Constant(context).width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: primaryColor,
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ...snapshots.data!.docs.map(((e) {
                                    classIdPkl = e.id;
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Kelas",
                                          style: TextStyle(
                                              fontSize: 28,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          e.get('supervisor'),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    );
                                  })),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/6.png",
                                        scale: 0.8,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: Constant(context).height * 0.02),
                          StreamBuilder<QuerySnapshot>(
                              stream: role == 'supervisor'
                                  ? widget.docRef == null
                                      ? FirebaseFirestore.instance
                                          .collection('class')
                                          .doc(widget.classId)
                                          .collection('task')
                                          .snapshots()
                                      : widget.docRef!
                                          .collection('task')
                                          .snapshots()
                                  : FirebaseFirestore.instance
                                      .collection('class')
                                      .doc(classIdPkl)
                                      .collection('task')
                                      .snapshots(),
                              builder: (context, taskSnapshot) {
                                if (taskSnapshot.hasData) {
                                  return Column(
                                    children: [
                                      ...taskSnapshot.data!.docs
                                          .map((task) => InkWell(
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              TaskRoom()));
                                                },
                                                child: CardTask(
                                                  title: task.get('title'),
                                                  post: formattedDate(
                                                      task.get('createdAt')),
                                                  taskId: task.id,
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
                  ),
                );
              }
              return CircularProgressIndicator();
            }),
        floatingActionButton: role == 'supervisor'
            ? FloatingActionButton(
                backgroundColor: primaryColor,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddTask(
                            docRef: widget.docRef,
                            classId: widget.classId,
                          )));
                },
                child: Icon(Icons.add),
              )
            : null);
  }
}
