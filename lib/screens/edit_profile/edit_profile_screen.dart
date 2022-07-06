import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
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
  late BuildContext dContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
    dContext = context;
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
      controllerJob = TextEditingController(text: doc.get('job'));
    });

    setState(() {});
  }

  showLoading({required BuildContext context}) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: '',
      transitionDuration: Duration(milliseconds: 100),
      pageBuilder: (context, animation1, animation2) {
        dContext = context;
        return Container();
      },
      transitionBuilder: (BuildContext context, a1, a2, widget) {
        dContext = context;
        return WillPopScope(
            onWillPop: () async => true,
            child: Center(child: CircularProgressIndicator()));
      },
    );
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
                                    image: DecorationImage(
                                        image: FileImage(newProfileTemp!),
                                        fit: BoxFit.cover)),
                          ),
                          TextButton(
                              onPressed: () async {
                                newProfile = (await AppImagePicker(context)
                                    .getImageGallery());
                                showLoading(context: context);

                                if (newProfile != null) {
                                  newProfileTemp = await newProfile;
                                  await FirebaseStorage.instance
                                      .ref('users/$uid/pfp.png')
                                      .putFile(newProfile!)
                                      .then((result) async {
                                    // Navigator.of(_).pop();
                                    String downloadUrl =
                                        await result.ref.getDownloadURL();

                                    // Simpan downloadUrl di collection user
                                    // teapal colletiona soalna
                                    await FirebaseFirestore.instance
                                        .doc("users/$uid")
                                        .set({
                                      "profile": downloadUrl,
                                    }, SetOptions(merge: true)).then((value) {
                                      Navigator.pop(dContext);
                                    });
                                  });
                                }
                                setState(() {});
                              },
                              child: Text(
                                "Ganti Foto Profil",
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
            keyboardType: TextInputType.name,
          ),
          TextFieldEdit(
            title: "Asal Sekolah",
            controller: controllerSchool,
            keyboardType: TextInputType.name,
          ),
          TextFieldEdit(
            title: "Jurusan",
            controller: controllerVacation,
            keyboardType: TextInputType.name,
          ),
          TextFieldEdit(
            title: "Alamat",
            controller: controllerAddress,
            keyboardType: TextInputType.name,
          ),
          TextFieldEdit(
            title: "Umur",
            controller: controllerAge,
            keyboardType: TextInputType.number,
          ),
          TextFieldEdit(
            title: "Hobi",
            controller: controllerHobby,
            keyboardType: TextInputType.name,
          ),
          TextFieldEdit(
            title: "Pekerjaan",
            controller: controllerJob,
            keyboardType: TextInputType.name,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: primaryColor),
              onPressed: () async {
                if (controllerName.text.isNotEmpty &&
                    controllerSchool.text.isNotEmpty &&
                    controllerAddress.text.isNotEmpty &&
                    controllerVacation.text.isNotEmpty &&
                    controllerAge.text.isNotEmpty &&
                    controllerHobby.text.isNotEmpty &&
                    controllerJob.text.isNotEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext ctx) => WillPopScope(
                            onWillPop: () async => false,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text(
                                'Peringatan!',
                                style: TextStyle(color: Colors.amber),
                              ),
                              content: Text("Apakah Anda Yakin?"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, 'Cancel'),
                                  child: const Text(
                                    'Kembali',
                                    style: TextStyle(color: primaryColor),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.pop(ctx);
                                    await users.get().then((doc) {
                                      if (doc.exists) {
                                        users.update({
                                          'name': controllerName.text,
                                          'school': controllerSchool.text,
                                          'job': controllerJob.text,
                                          'vacation': controllerVacation.text,
                                          'address': controllerAddress.text,
                                          'age': int.tryParse(
                                              controllerAge.text.trim()),
                                          'hobby': controllerHobby.text,
                                        });
                                      }
                                    });

                                    Navigator.of(context).pop(true);
                                  },
                                  child: const Text('OK',
                                      style: TextStyle(color: primaryColor)),
                                ),
                              ],
                            ),
                          ));
                } else
                  await Flushbar(
                    backgroundColor: Colors.red,
                    title: 'Tidak Boleh Kosong',
                    flushbarPosition: FlushbarPosition.TOP,
                    duration: Duration(seconds: 2),
                    message: 'Harus Terisi Semua',
                  ).show(context);
              },
              child: Text("Simpan"))
        ],
      ),
    );
  }
}
