import 'dart:async';

import 'package:edulab/contents.dart';
import 'package:edulab/screens/intro/intro.dart';
import 'package:edulab/screens/login/login.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }

  int _currentPage = 0;
  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController();

    List<Widget> _pages = [
      Intro(
          height: Constant(context).height / 100,
          width: Constant(context).width,
          image: Image.asset(
            "assets/images/3.png",
            scale: 3.5,
          ),
          title: "Temukan Pembelajaran \nOnline Terbaik",
          desc: "Pembelajaran UI/UX Menggunakan \nFigma yang Sangat Baik"),
      Intro(
          height: Constant(context).height / 100,
          width: Constant(context).width,
          image: Image.asset(
            "assets/images/2.png",
            scale: 2,
          ),
          title: "Ga tau Pusing",
          desc: "desc"),
      Intro(
          height: Constant(context).height / 100,
          width: Constant(context).width,
          image: Image.asset(
            "assets/images/1.png",
            scale: 3.2,
          ),
          title: "title",
          desc: "desc"),
    ];

    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: _controller,
            itemCount: _pages.length,
            onPageChanged: _onChanged,
            itemBuilder: (context, int index) {
              return _pages[index];
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(_pages.length, (int index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: Constant(context).height * 0.015,
                    width: (index == _currentPage)
                        ? Constant(context).width * 0.07
                        : Constant(context).width * 0.03,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: (index == _currentPage)
                            ? primaryColor
                            : primaryColor.withOpacity(0.5)),
                  );
                }),
              ),
              SizedBox(
                height: Constant(context).height * 0.06,
              ),
              Row(
                mainAxisAlignment: _currentPage == (_pages.length - 1)
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  (_currentPage == (_pages.length - 1)
                      ? const SizedBox()
                      : InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Button(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              color: Colors.white,
                              textColor: Colors.black,
                              border: Border.all(width: 1),
                              text: "Lewati"))),
                  InkWell(
                    onTap: () {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 800),
                          curve: Curves.easeOutQuint);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: Constant(context).height * 0.08,
                      alignment: Alignment.center,
                      width: Constant(context).width * 0.38,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: (_currentPage == (_pages.length - 1)
                          ? InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                              child: Button(
                                  height: Constant(context).height / 100,
                                  width: Constant(context).height / 100,
                                  color: primaryColor,
                                  textColor: Colors.white,
                                  text: "Login"),
                            )
                          : Button(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              color: primaryColor,
                              textColor: Colors.white,
                              text: "Selanjutnya")),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: Constant(context).height * 0.06,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startTimer() {
    Timer(Duration(seconds: 3), () {
      navigateUser(); //It will redirect  after 3 seconds
    });
  }

  void navigateUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var status = prefs.getBool('isLoggedIn') ?? false;
    print(status);
    if (status) {
      Navigator.of(context).pushReplacementNamed('/home');
    } else {
      Navigator.of(context).pushReplacementNamed('/intro');
    }
  }
}
