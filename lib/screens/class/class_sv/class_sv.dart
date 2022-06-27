import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/chat/chat.dart';
import 'package:edulab/screens/class/add_class/add_class.dart';
import 'package:edulab/screens/class/class.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClassSv extends StatefulWidget {
  const ClassSv({Key? key}) : super(key: key);

  @override
  State<ClassSv> createState() => _ClassSvState();
}

class _ClassSvState extends State<ClassSv> {
  String? name;
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    uid = prefs.getString('uid');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        actions: [
          Container(
              margin: EdgeInsets.only(right: 5),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddClass()));
                  },
                  icon: Icon(
                    Icons.add,
                    size: 25,
                  )))
        ],
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text("Daftar Kelas"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('class')
              .where('participants', arrayContains: uid)
              .snapshots(),
          builder: (_, snapshots) {
            if (snapshots.hasData) {
              return ListView(
                children: [
                  ...snapshots.data!.docs.map((e) =>
                      CardClass(classId: e.id, className: e.get('supervisor')))
                ],
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class CardClass extends StatelessWidget {
  final String classId;
  final String className;
  final DocumentReference<Map<String, dynamic>>? docRef;

  const CardClass({
    required this.classId,
    required this.className,
    this.docRef,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Class(
                  classId: classId,
                )));
      },
      child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: Icon(
                    Icons.book_outlined,
                    size: 45,
                  )),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    className,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
