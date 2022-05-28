import 'package:flutter/material.dart';

import 'otp_field.dart';

class VerifPage extends StatefulWidget {
  const VerifPage({Key? key}) : super(key: key);

  @override
  State<VerifPage> createState() => _VerifPageState();
}

class _VerifPageState extends State<VerifPage> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight / 100;
    final width = screenWidth / 100;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/4.png"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/5.png"),
              ],
            ),
            SizedBox(
              height: height * 5,
            ),
            const Text(
                "Silahkan cek SMS berupa kode verifikasi yang telah kami kirim ke nomor +628xxxxxxxxxx",
                style: TextStyle(
                  fontFamily: 'Inter-Bold',
                  fontSize: 14,
                ),
                textAlign: TextAlign.center),
            SizedBox(
              height: height * 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: width * 0.8,
                ),
                otp(context),
                SizedBox(
                  width: width * 0.8,
                ),
                otp(context),
                SizedBox(
                  width: width * 0.8,
                ),
                otp(context),
                SizedBox(
                  width: width * 0.8,
                ),
                otp(context),
                SizedBox(
                  width: width * 0.8,
                ),
                otp(context),
                SizedBox(
                  width: width * 0.8,
                ),
                otp(context),
                SizedBox(
                  width: width * 0.8,
                ),
              ],
            ),
            SizedBox(
              height: height * 1,
            ),
            SizedBox(
              width: width * 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info,
                    size: 25,
                  ),
                  SizedBox(width: width * 1),
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
