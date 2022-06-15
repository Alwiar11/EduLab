import 'package:edulab/login/login_shared.dart';
import 'package:edulab/verifikasi/verif_shared.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../shared/constant.dart';

class VerifPage extends StatefulWidget {
  const VerifPage({Key? key}) : super(key: key);

  @override
  State<VerifPage> createState() => _VerifPageState();
}

class _VerifPageState extends State<VerifPage> {
  var otpController = TextEditingController();
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
            Text(
                "Silahkan cek SMS berupa kode verifikasi yang telah kami kirim ke nomor " +
                    phonenumbercontroller.text,
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  fontSize: 14,
                ),
                textAlign: TextAlign.center),
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: [
            //     SizedBox(
            //       width: Constant(context).width * 0.008,
            //     ),
            //     otp(context, controller1),
            //     SizedBox(width: Constant(context).width * 0.008),
            //     otp(context, controller2),
            //     SizedBox(width: Constant(context).width * 0.008),
            //     otp(context, controller3),
            //     SizedBox(width: Constant(context).width * 0.008),
            //     otp(context, controller4),
            //     SizedBox(width: Constant(context).width * 0.008),
            //     otp(context, controller5),
            //     SizedBox(width: Constant(context).width * 0.008),
            //     otp(context, controller6),
            //     SizedBox(width: Constant(context).width * 0.008),
            //   ],
            // ),
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
