import 'package:edulab/contents.dart';
import 'package:edulab/screens/login/login_screen.dart';

import 'package:flutter/material.dart';

import 'functions/otp_function.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          OtpFunction(context).sendotp(
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
}
