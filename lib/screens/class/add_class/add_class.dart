import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/class/class.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddClass extends StatefulWidget {
  const AddClass({Key? key}) : super(key: key);

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  TextEditingController controllerNameClass = TextEditingController();
  String? uid;

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
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controllerNameClass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text('Tambah Kelas'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 15),
              height: 45,
              width: Constant(context).width * 0.9,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                controller: controllerNameClass,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 17),
                  // hintText: title,
                  labelText: 'Nama Kelas',
                  labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                  border: InputBorder.none,
                  // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                ),
              ),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(primary: primaryColor),
                onPressed: () async {
                  DocumentReference<Map<String, dynamic>> docRef =
                      await FirebaseFirestore.instance.collection('class').add({
                    'createdAt': Timestamp.now(),
                    'supervisor': controllerNameClass.text,
                    'participants': FieldValue.arrayUnion([uid]),
                  });
                  print(docRef.id);
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(uid)
                      .update({'classId': docRef.id});

                  Navigator.of(context).pop();
                },
                child: Text('Simpan'))
          ],
        ),
      ),
    );
  }
}
