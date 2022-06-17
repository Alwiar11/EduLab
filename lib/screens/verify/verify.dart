import 'package:edulab/screens/login/login_shared.dart';
import 'package:edulab/screens/verify/verify_shared.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verify extends StatefulWidget {
  const Verify({Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  String currentText = "";
  @override
  Widget build(BuildContext context) {
    return Container(
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
                              color: Colors.black, fontWeight: FontWeight.w500))
                    ])),
              ],
            ),
            SizedBox(
              height: Constant(context).height * 0.02,
            ),
            Form(
                child: PinCodeTextField(
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
                  const Text(
                    "Kode OTP sudah dikirim, anda dapat mengirim \nulang kode dalam 1:00",
                    style: TextStyle(fontSize: 13, fontFamily: "Inter"),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
