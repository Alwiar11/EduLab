import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight / 100;
    final width = screenWidth / 100;
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: height * 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/4.png",
                scale: 3,
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(height * 0.10),
            child: SizedBox(
              height: height * 1,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset("assets/images/5.png")],
          ),
          SizedBox(
            height: height * 10,
          ),
          Container(
            width: width * 90,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
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
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 76, 76, 76)),
                  ),
                  prefixIconConstraints:
                      BoxConstraints(minWidth: 0, minHeight: 0),
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 1),
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
                Text(
                  "Kami akan mengirimkan SMS untuk Verifikasi \nAkun ke nomor yang anda masukkan.",
                  style: TextStyle(fontSize: 13),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
