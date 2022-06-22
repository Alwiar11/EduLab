import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String title;
  const Label({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 35),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
