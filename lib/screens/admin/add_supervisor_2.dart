import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../edit_profile/textfield.dart';

class AddPkl2 extends StatefulWidget {
  final String userId;
  const AddPkl2({required this.userId, Key? key}) : super(key: key);

  @override
  State<AddPkl2> createState() => _AddPkl2State();
}

class _AddPkl2State extends State<AddPkl2> {
  TextEditingController controllerId = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userId)
        .get()
        .then((doc) {
      controllerId = TextEditingController(text: doc.get('pkl2'));
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text('Edit Anak Bimbing'),
      ),
      body: Column(
        children: [
          TextFieldEdit(
            title: "User Id",
            controller: controllerId,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryColor),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(widget.userId)
                    .update({'pkl2': controllerId.text});
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(controllerId.text)
                    .update({'supervisor': widget.userId});

                Navigator.of(context).pop();
              },
              child: Text("Simpan"))
        ],
      ),
    );
  }
}
