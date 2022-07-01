import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeRole extends StatefulWidget {
  final String classId;
  final DocumentReference<Map<String, dynamic>>? docRef;
  const ChangeRole({required this.classId, this.docRef, Key? key})
      : super(key: key);

  @override
  State<ChangeRole> createState() => _ChangeRoleState();
}

class _ChangeRoleState extends State<ChangeRole> {
  TextEditingController controllerNameClass2 = TextEditingController();
  String? uid;
  String? selectedValue;
  bool isSelectedValue = false;

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

  final List<String> roles = [
    'supervisor',
    'pkl',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          title: Text('Rubah Role'),
        ),
        body: FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('users').get(),
            builder: (context, snapshots) {
              if (snapshots.hasData) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                        color: secondaryColor,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                'Role',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            DropdownButton(
                              focusColor: Colors.white,
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.white,
                              value: selectedValue,
                              items: roles
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item,
                                        child: Text(
                                          item,
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value as String;
                                  isSelectedValue = true;
                                  print(value);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: primaryColor),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.classId)
                                .update({'role': selectedValue});
                            Navigator.of(context).pop();
                          },
                          child: Text("Simpan"))
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            }));
  }
}
