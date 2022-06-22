import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/home.dart';
import 'package:edulab/screens/add_data/add_data.dart';
import 'package:edulab/screens/verify/functions/verify_function.dart';
import 'package:edulab/screens/verify/verify.dart';
import 'package:edulab/screens/verify/verify_shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerifyScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationid;

  const VerifyScreen({
    required this.verificationid,
    required this.phoneNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController otpController = TextEditingController();
  //

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
                  VerifyFunction(context, widget.verificationid,
                          widget.phoneNumber, otpController)
                      .verify();
                },
                backgroundColor: primaryColor,
                child: const Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
        backgroundColor: secondaryColor,
        body: Verify(
          otpController: otpController,
        ));
  }
}
