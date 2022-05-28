import 'package:edulab/kelas/kelas_screen.dart';
import 'package:flutter/material.dart';

class Kelas extends StatelessWidget {
  const Kelas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      body: KelasScreen(),
    );
  }
}
