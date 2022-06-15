import 'package:edulab/contents.dart';
import 'package:edulab/login/login_screen.dart';
import 'package:edulab/login/login_shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../shared/constant.dart';
import '../verifikasi/verifikasi.dart';

class LoginPage extends StatelessWidget {
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationid = "";
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendotp(
            context: context,
          );
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => VerifScreen()));
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.keyboard_arrow_right),
      ),
      body: const LoginScreen(),
      backgroundColor: secondaryColor,
    );
  }

  Future<void> sendotp({required BuildContext context}) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phonenumbercontroller.text.toString(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          // print("Verification");
          // Navigator.push(context, MaterialPageRoute(builder : ))
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == "invalid-phone-number") {
            print("Invalid Phone Number");
          }
          print(e);
        },
        codeSent: (String verificationid, int? resendToken) async {
          print(verificationid);
          this.verificationid = verificationid;
          print(this.verificationid);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => VerifScreen()));
        },
        codeAutoRetrievalTimeout: (String verificationid) {});
  }
}
