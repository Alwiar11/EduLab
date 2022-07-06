import 'package:edulab/screens/verify/verify_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../login_shared.dart';

class OtpFunction {
  BuildContext dContext;

  final BuildContext context;
  OtpFunction(this.context, this.dContext);
  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationid = "";

  Future<void> sendotp({required BuildContext context}) async {
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
        return Center(child: CircularProgressIndicator());
      },
    );
    String phoneNumber = "+62" + phonenumbercontroller.text.toString();
    await auth.verifyPhoneNumber(
        timeout: Duration(seconds: 60),
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          print("Verification");
          // Navigator.push(context, MaterialPageRoute(builder : ))
        },
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == "invalid-phone-number") {}
          print(e);
        },
        codeSent: (String verificationid, int? resendToken) {
          print(verificationid);
          this.verificationid = verificationid;
          print(this.verificationid);

          Navigator.of(dContext).pop();

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
