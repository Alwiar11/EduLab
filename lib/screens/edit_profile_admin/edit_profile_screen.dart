import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/edit_profile/textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile_shared.dart';

class EditProfileAdminScreen extends StatefulWidget {
  const EditProfileAdminScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileAdminScreen> createState() => _EditProfileAdminScreenState();
}

class _EditProfileAdminScreenState extends State<EditProfileAdminScreen> {
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = await prefs.getString('uid');
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((doc) {
      controllerName = TextEditingController(text: doc.get('name'));
      controllerSchool = TextEditingController(text: doc.get('school'));
      controllerVacation = TextEditingController(text: doc.get('vacation'));
      controllerAddress = TextEditingController(text: doc.get('address'));
      controllerAge = TextEditingController(text: doc.get('age').toString());
      controllerHobby = TextEditingController(text: doc.get('hobby'));
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(uid);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          TextFieldEdit(
            title: "Nama",
            controller: controllerName,
            keyboardType: TextInputType.name,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryColor),
              onPressed: () {
                users.get().then((doc) {
                  if (doc.exists) {
                    users.update({
                      'name': controllerName.text,
                      'school': controllerSchool.text,
                      'vacation': controllerVacation.text,
                      'address': controllerAddress.text,
                      'age': int.tryParse(controllerAge.text) ?? "",
                      'hobby': controllerHobby.text,
                      'isVerified': false
                    });
                    Navigator.pop(context, true);
                  }
                });
              },
              child: Text("Simpan"))
        ],
      ),
    );
  }
}
