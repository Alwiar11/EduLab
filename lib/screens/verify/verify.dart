import 'package:edulab/screens/login/login_shared.dart';
import 'package:edulab/screens/verify/verify_shared.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Verify extends StatefulWidget {
  final TextEditingController otpController;
  const Verify({required this.otpController, Key? key}) : super(key: key);

  @override
  State<Verify> createState() => _VerifyState();
}

class _VerifyState extends State<Verify> {
  static const maxSeconds = 60;
  int seconds = maxSeconds;

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
              keyboardType: TextInputType.number,
              controller: widget.otpController,
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
                                    '$minutes:$seconds',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14)));
                      }),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}