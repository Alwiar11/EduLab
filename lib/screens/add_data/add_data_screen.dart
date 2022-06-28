import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/add_data/textfield.dart';
import 'package:edulab/waiting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home.dart';
import '../../shared/constant.dart';

class AddDataScreen extends StatefulWidget {
  const AddDataScreen({Key? key}) : super(key: key);

  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
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
    print(uid);
    DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(uid);
    var controllerName = TextEditingController();
    var controllerSchool = TextEditingController();
    var controllerAddress = TextEditingController();
    var controllerVacation = TextEditingController();
    var controllerAge = TextEditingController();
    var controllerHobby = TextEditingController();
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: Constant(context).height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/4.png",
                scale: 3,
              )
            ],
          ),
          SizedBox(
            height: Constant(context).height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset("assets/images/5.png")],
          ),
          SizedBox(
            height: Constant(context).height * 0.1,
          ),
          TextFields(controller: controllerName, title: "Nama Lengkap"),
          TextFields(controller: controllerSchool, title: "Asal Sekolah"),
          TextFields(controller: controllerVacation, title: "Jurusan"),
          TextFields(controller: controllerAddress, title: "Alamat"),
          TextFields(controller: controllerAge, title: "Umur"),
          TextFields(controller: controllerHobby, title: "Hobby"),
          InkWell(
            onTap: () {
              users.get().then((doc) async {
                if (doc.exists) {
                  DocumentReference<Object?> docRef = users;
                  users.update({
                    'name': controllerName.text,
                    'school': controllerSchool.text,
                    'vacation': controllerVacation.text,
                    'address': controllerAddress.text,
                    'age': int.tryParse(controllerAge.text) ?? "",
                    'hobby': controllerHobby.text,
                    'isVerified': false,
                    'profile': "",
                    'role': "pkl",
                    'supervisor': '',
                    'startFromDate': Timestamp.now(),
                    'endFromDate': Timestamp.now(),
                    'job': 'pelajar',
                    'classId': ''
                  });
                  if (doc.get('isVerified') == true) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Home()),
                        (Route<dynamic> route) => false);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => Waiting(
                                  userId: uid ?? '',
                                )),
                        (Route<dynamic> route) => false);
                  }
                }
              });
            },
            child: Container(
                margin: EdgeInsets.only(top: 5),
                height: 45,
                width: 90,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Simpan",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          )
        ],
      )),
    );
  }
}
