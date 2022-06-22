import 'package:flutter/material.dart';

import '../../contents.dart';
import 'add_data_screen.dart';

class AddData extends StatelessWidget {
  final String uid;
  AddData({required this.uid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const AddDataScreen(),
      backgroundColor: secondaryColor,
    );
  }
}
