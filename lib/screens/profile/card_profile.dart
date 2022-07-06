import 'package:edulab/contents.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';

class CardProfile extends StatelessWidget {
  const CardProfile({
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
          padding: EdgeInsets.symmetric(vertical: 10),
          width: width * 90,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Constant(context).width * 0.7,
                child: Text(
                  desc,
                  style: TextStyle(
                      overflow: TextOverflow.fade,
                      fontFamily: "Inter",
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
