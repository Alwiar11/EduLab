import 'package:edulab/screens/class/class_screen.dart';
import 'package:flutter/material.dart';

class Class extends StatelessWidget {
  const Class({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: ClassScreen(),
    );
  }
}
