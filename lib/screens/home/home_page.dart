import 'package:edulab/screens/home/home_page_screen.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 232, 232, 232),
      body: HomePageScreen(
          height: Constant(context).height, width: Constant(context).width),
    );
  }
}
