import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/edit_profile/textfield.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'edit_profile_shared.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
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
          ),
          TextFieldEdit(
            title: "Asal Sekolah",
            controller: controllerSchool,
          ),
          TextFieldEdit(
            title: "Jurusan",
            controller: controllerVacation,
          ),
          TextFieldEdit(
            title: "Alamat",
            controller: controllerAddress,
          ),
          TextFieldEdit(
            title: "Umur",
            controller: controllerAge,
          ),
          TextFieldEdit(
            title: "Hobi",
            controller: controllerHobby,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryColor),
              onPressed: () async {
                //
                showDialog(
                    context: context,
                    builder: (BuildContext _) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          title: Text(
                            'Peringatan!',
                            style: TextStyle(color: Colors.amber),
                          ),
                          content: Text("Apakah Anda Yakin?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(_, 'Cancel'),
                              child: const Text(
                                'Kembali',
                                style: TextStyle(color: primaryColor),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                users.get().then((doc) {
                                  if (doc.exists) {
                                    users.update({
                                      'name': controllerName.text,
                                      'school': controllerSchool.text,
                                      'vacation': controllerVacation.text,
                                      'address': controllerAddress.text,
                                      'age': int.tryParse(controllerAge.text) ??
                                          "",
                                      'hobby': controllerHobby.text,
                                      'isVerified': false
                                    });
                                    Navigator.of(_).pop();
                                  }
                                  Navigator.of(context).pop(true);
                                });
                              },
                              child: const Text('OK',
                                  style: TextStyle(color: primaryColor)),
                            ),
                          ],
                        ));
              },
              child: Text("Simpan"))
        ],
      ),
    );
  }
}
