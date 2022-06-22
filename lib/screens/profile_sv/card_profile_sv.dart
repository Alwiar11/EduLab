import 'package:edulab/contents.dart';
import 'package:flutter/material.dart';

class CardProfileSv extends StatelessWidget {
  const CardProfileSv({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.desc,
  }) : super(key: key);

  final double height;
  final double width;
  final String title;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
              fontFamily: "Inter", fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Container(
          height: height * 6,
          width: width * 90,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                desc,
                style: TextStyle(
                    fontFamily: "Inter", fontSize: 16, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ],
    );
  }
}
