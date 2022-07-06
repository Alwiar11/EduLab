import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddClassParticpants extends StatefulWidget {
  final String classId;
  final DocumentReference<Map<String, dynamic>>? docRef;
  const AddClassParticpants({required this.classId, this.docRef, Key? key})
      : super(key: key);

  @override
  State<AddClassParticpants> createState() => _AddClassParticpantsState();
}

class _AddClassParticpantsState extends State<AddClassParticpants> {
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

  @override
  Widget build(BuildContext context) {
    print(widget.classId);
    print(widget.docRef.toString());
    String? _selectedValue;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          title: Text('Tambah Anggota'),
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
                                'Nama Anak Bimbing',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ),
                            DropdownButton(
                              focusColor: Colors.white,
                              dropdownColor: Colors.white,
                              iconEnabledColor: Colors.white,
                              value: selectedValue,
                              items: snapshots.data!.docs
                                  .where(
                                      (element) => element.reference.id != uid)
                                  .where((element) =>
                                      element.get('role') != 'admin')
                                  .where((element) =>
                                      element.get('role') != 'supervisor')
                                  .map(
                                (e) {
                                  String name = e.get('name');
                                  return DropdownMenuItem(
                                      value: e.id,
                                      child: SizedBox(
                                        width: 180,
                                        child: Text(
                                          e.get(
                                            'name',
                                          ),
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ));
                                },
                              ).toList(),
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
                      isSelectedValue == true
                          ? ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: primaryColor),
                              onPressed: () {
                                widget.classId.isEmpty
                                    ? widget.docRef!.update({
                                        'participants': FieldValue.arrayUnion(
                                            [selectedValue]),
                                      })
                                    : FirebaseFirestore.instance
                                        .collection('class')
                                        .doc(widget.classId)
                                        .update({
                                        'participants': FieldValue.arrayUnion(
                                            [selectedValue]),
                                      });

                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(selectedValue)
                                    .set({'classId': widget.classId},
                                        SetOptions(merge: true));

                                Navigator.of(context).pop();
                                print(selectedValue);
                              },
                              child: Text("Simpan"))
                          : ElevatedButton(
                              onPressed: null, child: Text("Simpan"))
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            }));
  }
}
