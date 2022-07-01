import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/edit_profile/textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/constant.dart';
import '../../shared/image_picker.dart';
import 'edit_profile_shared.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? newProfile;
  File? newProfileTemp;
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
          uid != null
              ? StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Container(
                            height: Constant(context).height * 0.26,
                            width: Constant(context).width * 0.5,
                            decoration: newProfile == null
                                ? BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: snapshot.data!.get("profile") != ""
                                        ? DecorationImage(
                                            image: NetworkImage(
                                                snapshot.data!.get("profile")),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: AssetImage(
                                                "assets/images/default.png"),
                                            fit: BoxFit.cover),
                                    border: Border.all(
                                        width: 10, color: primaryColor))
                                : BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: snapshot.data!.get("profile") != ""
                                        ? DecorationImage(
                                            image: FileImage(newProfileTemp!),
                                            fit: BoxFit.cover)
                                        : DecorationImage(
                                            image: AssetImage(
                                                "assets/images/default.png"),
                                            fit: BoxFit.cover),
                                    border: Border.all(
                                        width: 10, color: primaryColor)),
                          ),
                          TextButton(
                              onPressed: () async {
                                newProfile = await AppImagePicker(context)
                                    .getImageGallery();
                                if (newProfile != null) {
                                  newProfileTemp = await newProfile;
                                }
                                setState(() {});
                                print(newProfileTemp);
                              },
                              child: Text(
                                "Ganti Foto Profile",
                                style: TextStyle(color: primaryColor),
                              ))
                        ],
                      );
                    }
                    return CircularProgressIndicator(
                      color: primaryColor,
                      strokeWidth: 10,
                    );
                  })
              : CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 10,
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
                                if (newProfile != null) {
                                  FirebaseStorage.instance
                                      .ref('users/$uid/pfp.png')
                                      .putFile(newProfile!)
                                      .then((result) async {
                                    String downloadUrl =
                                        await result.ref.getDownloadURL();
                                    // Simpan downloadUrl di collection user
                                    // teapal colletiona soalna
                                    FirebaseFirestore.instance
                                        .doc("users/$uid")
                                        .set({
                                      "profile": downloadUrl,
                                    }, SetOptions(merge: true)).then((value) {
                                      print("done");
                                    });
                                  });
                                } else {
                                  //TODO: Handle null
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            title: Text(
                                              'Peringatan!',
                                              style: TextStyle(
                                                  color: Colors.amber),
                                            ),
                                            content: Text("Gagal"),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, 'Cancel'),
                                                child: const Text(
                                                  'Kembali',
                                                  style: TextStyle(
                                                      color: primaryColor),
                                                ),
                                              ),
                                            ],
                                          ));
                                }
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
