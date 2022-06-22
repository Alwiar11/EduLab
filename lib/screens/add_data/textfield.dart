import 'package:edulab/contents.dart';
import 'package:flutter/material.dart';

import '../../shared/constant.dart';

class TextFields extends StatelessWidget {
  final controller;
  final String title;

  const TextFields({
    required this.controller,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        height: 45,
        width: Constant(context).width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 17),
            // hintText: title,
            labelText: title,
            labelStyle: TextStyle(color: primaryColor, fontSize: 16),
            border: InputBorder.none,
            // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
        ),
      ),
    );
  }
}
