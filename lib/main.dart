import 'package:edulab/home_admin.dart';
import 'package:edulab/screens/intro/intro_screen.dart';
import 'package:edulab/waiting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';

void main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var uid = prefs.getString('uid');
  var role = prefs.getString('role');
  var isVerified = prefs.getBool('isVerified');

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: uid == null
          ? IntroScreen()
          : role == 'admin'
              ? HomeAdmin()
              : Home()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroScreen(),
    );
  }
}
