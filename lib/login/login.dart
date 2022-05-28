import 'package:edulab/contents.dart';
import 'package:edulab/login/login_screen.dart';
import 'package:flutter/material.dart';
import '../verifikasi/verifikasi.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VerifScreen()),
          );
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.keyboard_arrow_right),
      ),
      body: const LoginScreen(),
      backgroundColor: secondaryColor,
    );
  }
}
