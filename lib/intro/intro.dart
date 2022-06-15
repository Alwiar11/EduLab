import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../contents.dart';

class Intro extends StatelessWidget {
  final double height;
  final double width;
  final Image image;
  final String title;
  final String desc;

  const Intro({
    Key? key,
    required this.height,
    required this.width,
    required this.image,
    required this.title,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
              width: Constant(context).width,
              height: Constant(context).height * 0.5,
              color: secondaryColor,
              child: image),
        ),
        SizedBox(
          height: Constant(context).height * 0.05,
        ),
        Text(title,
            style: const TextStyle(
                fontFamily: 'Inter-Bold',
                fontSize: 24,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        SizedBox(
          height: Constant(context).height * 0.04,
        ),
        Text(
          desc,
          style: const TextStyle(
              fontFamily: 'Inter-Regular',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: Constant(context).height * 0.1,
        ),
      ],
    );
  }
}
