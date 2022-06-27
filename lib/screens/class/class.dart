import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/class/add_class_participants.dart';

import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
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
                                  ...snapshots.data!.docs.map(((e) => Column(
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
                                      ))),
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintStyle: const TextStyle(fontSize: 10),
                                      hintText:
                                          '    Umumkan Sesuatu di Kelas Anda',
                                      border: InputBorder.none,
                                      prefixIcon: Container(
                                        height: Constant(context).height * 0.05,
                                        width: Constant(context).width * 0.1,
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: primaryColor),
                                      ),
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                              minWidth: 0, minHeight: 0),
                                      contentPadding: const EdgeInsets.all(20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Constant(context).height * 0.02,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            width: Constant(context).width,
                            // height: height * 15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: Constant(context).width * 0.02,
                                ),
                                Container(
                                  height: Constant(context).height * 0.1,
                                  width: Constant(context).width * 0.2,
                                  decoration: const BoxDecoration(
                                    color: primaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.work_outline_rounded,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                                SizedBox(
                                  width: Constant(context).width * 0.01,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Tugas Membuat Row",
                                      style: TextStyle(
                                          fontFamily: "Inter",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text("Diposting 2 Maret",
                                        style: TextStyle(
                                            fontFamily: "Inter",
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.grey)),
                                  ],
                                )
                              ],
                            ),
                          )
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
                onPressed: () {},
                child: Icon(Icons.add),
              )
            : null);
  }
}
