import 'package:edulab/contents.dart';
import 'package:edulab/home.dart';
import 'package:edulab/verifikasi/verif.dart';
import 'package:edulab/verifikasi/verif_shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifScreen extends StatefulWidget {
  const VerifScreen({Key? key}) : super(key: key);

  @override
  State<VerifScreen> createState() => _VerifScreenState();
}

class _VerifScreenState extends State<VerifScreen> {
  var otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  String verificationid = "";

  void signInWithPhoneAuthCredentail(
      PhoneAuthCredential phoneAuthCredential) async {
    try {
      print('kadieu te');
      await auth.signInWithCredential(phoneAuthCredential).then(
        (UserCredential userCredential) {
          print(userCredential);
          if (userCredential.user != null) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          } else {
            print("hmmmm");
          }
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: primaryColor,
                child: const Icon(Icons.keyboard_arrow_left),
              ),
              FloatingActionButton(
                onPressed: () {
                  verify();
                },
                backgroundColor: primaryColor,
                child: const Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
        backgroundColor: secondaryColor,
        body: const VerifPage());
  }

  Future<void> verify() async {
    print(verificationid);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: verificationid, smsCode: otpController.text.toString());
    signInWithPhoneAuthCredentail(phoneAuthCredential);
  }
}
