import 'package:edulab/contents.dart';
import 'package:edulab/screens/class/class.dart';
import 'package:edulab/screens/home/home_page.dart';

import 'package:edulab/screens/chat/chat.dart';
import 'package:edulab/screens/profile/profile.dart';

import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [const HomePage(), const Class(), Chat(), Profile()],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: const <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home_outlined),
            title: Text('Beranda'),
            activeColor: primaryColor,
            activeIconColor: primaryColor,
            activeTitleColor: primaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.class__outlined),
            title: Text('Kelas'),
            activeColor: primaryColor,
            activeIconColor: primaryColor,
            activeTitleColor: primaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.chat_outlined),
            title: Text('Pesan'),
            activeColor: primaryColor,
            activeIconColor: primaryColor,
            activeTitleColor: primaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.person_outline),
            title: Text('Akun Saya'),
            activeColor: primaryColor,
            activeIconColor: primaryColor,
            activeTitleColor: primaryColor,
          ),
        ],
      ),
    );
  }
}
