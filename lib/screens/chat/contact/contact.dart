import 'package:edulab/contents.dart';
import 'package:flutter/material.dart';

import 'contact_screen.dart';

class Contact extends StatelessWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Kontak"),
        ),
        body: ContactScreen());
  }
}
