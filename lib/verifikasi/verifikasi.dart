import 'package:edulab/contents.dart';
import 'package:edulab/home.dart';
import 'package:edulab/verifikasi/verif.dart';
import 'package:flutter/material.dart';

class VerifScreen extends StatefulWidget {
  const VerifScreen({Key? key}) : super(key: key);

  @override
  State<VerifScreen> createState() => _VerifScreenState();
}

class _VerifScreenState extends State<VerifScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                backgroundColor: primaryColor,
                child: const Icon(Icons.keyboard_arrow_left),
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => const Home()),
                      ModalRoute.withName('/'));
                },
                backgroundColor: primaryColor,
                child: const Icon(Icons.keyboard_arrow_right),
              ),
            ],
          ),
        ),
        backgroundColor: secondaryColor,
        body: const VerifPage());
  }
}
