import 'package:edulab/contents.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight / 100;
    final width = screenWidth / 100;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
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
            height: height * 10,
          ),
          Container(
            width: width * 85,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(15),
            ),
            child: const Padding(
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: 17),
                  hintText: 'Masukkan No Hp',
                  border: InputBorder.none,
                  prefixIcon: Text(
                    "+62      ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 76, 76, 76)),
                  ),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, top: 10),
            child: Row(
              children: [
                const Icon(
                  Icons.warning,
                  size: 23,
                ),
                SizedBox(
                  width: width * 1,
                ),
                const Text(
                  "Kami akan mengirimkan SMS untuk Verifikasi Akun \nke nomor yang anda masukkan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
