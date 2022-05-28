import 'package:flutter/material.dart';

class Constant {
  final BuildContext context;
  Constant(this.context);

  double get screenHeight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;
  double get width => screenWidth;
  double get height => screenHeight;
}
