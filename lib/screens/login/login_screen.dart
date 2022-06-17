import 'package:edulab/screens/login/login_shared.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(Constant(context).height * 0.001),
            child: SizedBox(
              height: Constant(context).height * 0.01,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image.asset("assets/images/5.png")],
          ),
          SizedBox(
            height: Constant(context).height * 0.1,
          ),
          Container(
            width: Constant(context).width * 0.9,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 20),
              child: TextField(
                controller: phonenumbercontroller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
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
          SizedBox(height: Constant(context).height * 0.01),
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
