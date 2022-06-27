import 'package:flutter/material.dart';

Container cardList(double width, double height, Color color,
    {Widget? leading}) {
  return Container(
    width: width,
    height: height,
    decoration:
        BoxDecoration(color: color, borderRadius: BorderRadius.circular(15)),
    child: ListTile(leading: leading),
  );
}
