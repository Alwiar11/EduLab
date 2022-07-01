import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/home_admin.dart';
import 'package:edulab/screens/login/login_shared.dart';
import 'package:edulab/waiting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../home.dart';
import '../../add_data/add_data.dart';
import '../verify_shared.dart';

class VerifyFunction {
  final BuildContext context;
  final String verificationid;
  final String phoneNumber;
  final TextEditingController otpController;
  VerifyFunction(
      this.context, this.verificationid, this.phoneNumber, this.otpController);

  FirebaseAuth auth = FirebaseAuth.instance;

  void signInWithPhoneAuthCredentail(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      print(otpController.text);
      print(verificationid);

      print('kadieu te');
      await auth.signInWithCredential(phoneAuthCredential).then(
        (UserCredential userCredential) {
          print(userCredential);
          if (userCredential.user != null) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(userCredential.user!.uid)
                .get()
                .then(
              (doc) async {
                if (doc.exists) {
                  // TODO simpan data user ke device
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('uid', userCredential.user!.uid);

                  prefs.setString('name', doc.get('name'));
                  // String? name = prefs.getString('name');

                  prefs.setString('school', doc.get("school"));
                  // String? school = prefs.getString('school');

                  prefs.setString('vacation', doc.get("vacation"));
                  // String? vacation = prefs.getString('vacation');

                  prefs.setString('address', doc.get("address"));
                  // String? address = prefs.getString('address');

                  prefs.setString('hobby', doc.get("hobby"));
                  // String? hobby = prefs.getString('hobby');

                  prefs.setInt('age', doc.get("age"));
                  // String? age = prefs.getString('age');

                  prefs.setString('role', doc.get("role"));
                  // String? role = prefs.getString('role');

                  prefs.setString('phoneNumber', doc.get("phoneNumber"));
                  // String? phoneNumber = prefs.getString('phoneNumber');

                  prefs.setString('profile', doc.get("profile"));
                  // String? profile = prefs.getString('profile');

                  prefs.setBool('isVerified', doc.get("isVerified"));
                  // String? isVerified = prefs.getString('isVerified');

                  if (doc.get("isVerified") == true) {
                    if (doc.get("role") == 'pkl') {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Home()),
                          (Route<dynamic> route) => false);
                    } else if (doc.get('role') == 'supervisor') {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => Home()),
                          (Route<dynamic> route) => false);
                    } else
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => HomeAdmin()),
                          (Route<dynamic> route) => false);
                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => Waiting(
                                  userId: userCredential.user!.uid,
                                )),
                        (Route<dynamic> route) => false);
                  }
                } else {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('uid', userCredential.user!.uid);
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(userCredential.user!.uid)
                      .set({
                    'phoneNumber': phoneNumber,
                  });

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AddData(
                        uid: userCredential.user!.uid,
                      ),
                    ),
                  );
                }
              },
            );
          } else {
            print("hmmmm");
          }
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> verify() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationid, smsCode: otpController.text);
    signInWithPhoneAuthCredentail(phoneAuthCredential);
    phonenumbercontroller.clear();
  }
}
