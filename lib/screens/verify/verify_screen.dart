import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/home.dart';
import 'package:edulab/screens/add_data/add_data.dart';
import 'package:edulab/screens/verify/functions/verify_function.dart';

import 'package:edulab/screens/verify/verify_shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/constant.dart';
import '../login/login_shared.dart';

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
  static const maxSeconds = 60;
  int seconds = maxSeconds;

  String currentText = "";
  late BuildContext dContext;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dContext = context;
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
              heroTag: 'btnnext',
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: primaryColor,
              child: const Icon(Icons.keyboard_arrow_left),
            ),
            FloatingActionButton(
              heroTag: 'btnbck',
              onPressed: () {
                if (otpController.text.isNotEmpty) {
                  VerifyFunction(context, widget.verificationid,
                          widget.phoneNumber, otpController)
                      .verify();
                } else
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tidak Boleh Kosong'),
                      backgroundColor: Colors.red,
                    ),
                  );
              },
              backgroundColor: primaryColor,
              child: const Icon(Icons.keyboard_arrow_right),
            ),
          ],
        ),
      ),
      backgroundColor: secondaryColor,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Column(
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
                  ),
                ],
              ),
              SizedBox(
                height: Constant(context).height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/5.png"),
                ],
              ),
              SizedBox(
                height: Constant(context).height * 0.05,
              ),
              Column(
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Kode OTP sudah dikirim ke Nomor ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w400),
                          children: [
                        TextSpan(
                            text: "0" + phonenumbercontroller.text.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500))
                      ])),
                ],
              ),
              SizedBox(
                height: Constant(context).height * 0.02,
              ),
              Form(
                  child: PinCodeTextField(
                keyboardType: TextInputType.number,
                controller: otpController,
                appContext: context,
                length: 6,
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    currentText = value;
                  });
                },
              )),
              SizedBox(
                height: Constant(context).height * 0.01,
              ),
              SizedBox(
                width: Constant(context).width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.info,
                      size: 25,
                    ),
                    SizedBox(width: Constant(context).width * 0.01),
                    TweenAnimationBuilder<Duration>(
                        duration: Duration(minutes: 1),
                        tween: Tween(
                            begin: Duration(minutes: 1), end: Duration.zero),
                        onEnd: () {
                          print('Timer ended');
                        },
                        builder: (BuildContext context, Duration value,
                            Widget? child) {
                          final minutes = value.inMinutes;
                          final seconds = value.inSeconds % 60;
                          return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                  'Anda dapat mengirim ulang kode OTP dalam ' +
                                      '\n$minutes:$seconds',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)));
                        }),
                  ],
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
