import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/add_data/textfield.dart';
import 'package:edulab/waiting.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerSchool = TextEditingController();
  TextEditingController controllerAddress = TextEditingController();
  TextEditingController controllerVacation = TextEditingController();
  TextEditingController controllerAge = TextEditingController();
  TextEditingController controllerHobby = TextEditingController();
  TextEditingController controllerStart = TextEditingController();
  TextEditingController controllerEnd = TextEditingController();
  TextEditingController controllerJob = TextEditingController();
  DateTime dateTime = DateTime.now();
  DateTime dateTime2 = DateTime.now();

  selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      controllerStart.text = DateFormat('EEE d MMM y').format(dateTime);
    }
  }

  selectDate2() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime2,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime2 = picked;
      //assign the chosen date to the controller
      controllerEnd.text = DateFormat('EEE d MMM y').format(dateTime2);
    }
  }

  @override
  Widget build(BuildContext context) {
    DocumentReference users =
        FirebaseFirestore.instance.collection('users').doc(uid);

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
          TextFields(
            controller: controllerName,
            title: "Nama Lengkap",
            type: TextInputType.name,
          ),
          TextFields(
              controller: controllerSchool,
              title: "Asal Sekolah",
              type: TextInputType.name),
          TextFields(
              controller: controllerVacation,
              title: "Jurusan",
              type: TextInputType.name),
          TextFields(
              controller: controllerAddress,
              title: "Alamat",
              type: TextInputType.name),
          TextFields(
              controller: controllerAge,
              title: "Umur",
              type: TextInputType.number),
          TextFields(
              controller: controllerHobby,
              title: "Hobby",
              type: TextInputType.name),
          TextFields(
              controller: controllerJob,
              title: "Pekerjaan",
              type: TextInputType.name),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Container(
                height: 45,
                width: Constant(context).width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  onTap: selectDate,
                  readOnly: true,
                  controller: controllerStart,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    // hintText: title,
                    labelText: 'Tanggal Masuk',
                    prefixIcon: Icon(
                      Icons.timer,
                      color: primaryColor,
                    ),

                    labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                    border: InputBorder.none,
                    // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Container(
                height: 45,
                width: Constant(context).width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  onTap: selectDate2,
                  readOnly: true,
                  controller: controllerEnd,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    // hintText: title,
                    labelText: 'Tanggal Keluar',
                    prefixIcon: Icon(
                      Icons.timer,
                      color: primaryColor,
                    ),

                    labelStyle: TextStyle(color: primaryColor, fontSize: 16),
                    border: InputBorder.none,
                    // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              users.get().then((doc) {
                if (doc.exists) {
                  DocumentReference<Object?> docRef = users;
                  users.set({
                    'name': controllerName.text,
                    'school': controllerSchool.text,
                    'vacation': controllerVacation.text,
                    'address': controllerAddress.text,
                    'age': int.tryParse(controllerAge.text),
                    'hobby': controllerHobby.text,
                    'isVerified': false,
                    'profile': "",
                    'role': "pkl",
                    'startFromDate': Timestamp.fromDate(dateTime),
                    'endFromDate': Timestamp.fromDate(dateTime2),
                    'job': controllerJob.text,
                    'classId': '',
                  }, SetOptions(merge: true));
                  if (doc.get('isVerified') != true) {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => Waiting(
                                  userId: uid ?? '',
                                )),
                        (Route<dynamic> route) => false);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Home()),
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
