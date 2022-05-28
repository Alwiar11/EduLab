import 'package:flutter/material.dart';

Container cardList(double width, double height, Color color) {
  return Container(
    width: width * 60,
    height: height * 14,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
  );
}
