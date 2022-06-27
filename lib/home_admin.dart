import 'package:edulab/contents.dart';
import 'package:edulab/screens/admin/home%20admin/home_page_admin.dart';
import 'package:edulab/screens/admin/home%20admin/home_page_admin_pkl.dart';
import 'package:edulab/screens/admin/home%20admin/profile_admin.dart';
import 'package:edulab/screens/chat/contact/contact.dart';
import 'package:edulab/screens/class/class.dart';

import 'package:edulab/screens/home/home_page.dart';

import 'package:edulab/screens/chat/chat.dart';
import 'package:edulab/screens/profile/profile.dart';

import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';

class HomeAdmin extends StatelessWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Bar Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeAdminScreen(),
    );
  }
}

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({Key? key}) : super(key: key);

  @override
  _HomeAdminScreenState createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          HomePageAdmin(),
          HomePageAdminPkl(),
          ProfileAdmin(),
        ],
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
            icon: Icon(Icons.people_alt_sharp),
            title: Text('Supervisor'),
            activeColor: primaryColor,
            activeIconColor: primaryColor,
            activeTitleColor: primaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.people_alt_sharp),
            title: Text('PKL'),
            activeColor: primaryColor,
            activeIconColor: primaryColor,
            activeTitleColor: primaryColor,
          ),
          BottomBarItem(
            icon: Icon(Icons.person_pin_circle_outlined),
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
