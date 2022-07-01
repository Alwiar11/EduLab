import 'package:edulab/home.dart';
import 'package:edulab/home_admin.dart';
import 'package:edulab/screens/intro/intro_screen.dart';
import 'package:edulab/waiting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthChecker extends StatefulWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  State<AuthChecker> createState() => _AuthCheckerState();
}

class _AuthCheckerState extends State<AuthChecker> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authChecker();
  }

  authChecker() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uid = await prefs.getString('uid');
    var role = await prefs.getString('role');
    var isVerified = await prefs.getBool('isVerified');
    if (uid != null) {
      if (isVerified != null && isVerified == false) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Waiting(
                      userId: uid,
                    )));
      } else {
        if (role != 'admin') {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeAdmin(),
            ),
          );
        }
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
