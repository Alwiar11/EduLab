import 'package:edulab/screens/verify/verify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_shared.dart';

class OtpFunction {
  final BuildContext context;
  OtpFunction(this.context);
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationid = "";

  Future<void> sendotp({required BuildContext context}) async {
    String phoneNumber = "+62" + phonenumbercontroller.text.toString();
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Verification");
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
            context,
            MaterialPageRoute(
              builder: (context) => VerifyScreen(
                verificationid: verificationid,
                phoneNumber: phoneNumber,
              ),
            ),
          );
        },
        codeAutoRetrievalTimeout: (String verificationid) {});
  }
}
