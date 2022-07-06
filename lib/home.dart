import 'package:edulab/contents.dart';
import 'package:edulab/screens/chat/contact/contact.dart';
import 'package:edulab/screens/class/class.dart';
import 'package:edulab/screens/class/class_sv/class_sv.dart';
import 'package:edulab/screens/home/home_page.dart';

import 'package:edulab/screens/chat/chat.dart';
import 'package:edulab/screens/profile/profile.dart';

import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  String? role;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    role = prefs.getString('role');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [const HomePage(), ClassSv(), Chat(), Profile()],
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
            icon: Icon(Icons.class_outlined),
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
