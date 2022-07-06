import 'package:edulab/contents.dart';

import 'package:edulab/screens/login/login_shared.dart';

import 'package:flutter/material.dart';

import '../../shared/constant.dart';
import 'functions/otp_function.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late BuildContext dContext;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dContext = context;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (phonenumbercontroller.text.isNotEmpty) {
            OtpFunction(context, dContext).sendotp(
              context: context,
            );
          } else
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  backgroundColor: Colors.red,
                  content: Text('TIdak Boleh Kosong')),
            );
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.keyboard_arrow_right),
      ),
      body: SingleChildScrollView(
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
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
      ),
      backgroundColor: secondaryColor,
    );
  }
}
