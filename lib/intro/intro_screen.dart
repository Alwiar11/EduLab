import 'package:edulab/contents.dart';
import 'package:edulab/intro/intro.dart';
import 'package:edulab/login/login.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentPage = 0;
  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight / 100;
    final width = screenWidth / 100;
    PageController _controller = PageController();

    List<Widget> _pages = [
      Intro(
          height: height,
          width: screenWidth,
          image: Image.asset(
            "assets/images/3.png",
            scale: 3.5,
          ),
          title: "Temukan Pembelajaran \nOnline Terbaik",
          desc: "Pembelajaran UI/UX Menggunakan \nFigma yang Sangat Baik"),
      Intro(
          height: height,
          width: screenWidth,
          image: Image.asset(
            "assets/images/2.png",
            scale: 2,
          ),
          title: "Ga tau Pusing",
          desc: "desc"),
      Intro(
          height: height,
          width: screenWidth,
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
                    height: height * 1.5,
                    width: (index == _currentPage) ? width * 7 : width * 3,
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
                height: height * 6,
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
                                  builder: (context) => const LoginPage()),
                            );
                          },
                          child: Button(
                              height: height,
                              width: width,
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
                      height: height * 8,
                      alignment: Alignment.center,
                      width: width * 38,
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
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: Button(
                                  height: height,
                                  width: width,
                                  color: primaryColor,
                                  textColor: Colors.white,
                                  text: "Login"),
                            )
                          : Button(
                              height: height,
                              width: width,
                              color: primaryColor,
                              textColor: Colors.white,
                              text: "Selanjutnya")),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 6,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
