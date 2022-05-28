import 'package:edulab/home/home_page_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight / 100;
    final width = screenWidth / 100;
    return Scaffold(
      backgroundColor: const Color.fromARGB(232, 232, 232, 232),
      body: HomePageScreen(height: height, width: width),
    );
  }
}
