import 'package:flutter/material.dart';
import '../contents.dart';
import 'card.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              SizedBox(
                height: height * 2,
              ),
              Row(
                children: [
                  Container(
                    width: width * 22,
                    height: height * 10,
                    decoration: const BoxDecoration(
                        color: primaryColor, shape: BoxShape.circle),
                  ),
                  SizedBox(
                    width: width * 2,
                  ),
                  const Text(
                    "Hi, Alwi \nHow Are You?",
                    style: TextStyle(fontSize: 18, fontFamily: "Inter"),
                  ),
                ],
              ),
              SizedBox(
                height: height * 2.5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Supervisor",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter"),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Selengkapnya",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color.fromARGB(255, 40, 119, 255)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 2.5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    cardList(width, height, primaryColor),
                    const SizedBox(
                      width: 35,
                    ),
                    cardList(width, height, primaryColor),
                    const SizedBox(
                      width: 35,
                    ),
                    cardList(width, height, primaryColor),
                  ],
                ),
              ),
              SizedBox(
                height: height * 2.5,
              ),
              Row(
                children: const [
                  Text(
                    "Pengingat",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        fontFamily: "Inter"),
                  )
                ],
              ),
              SizedBox(
                height: height * 2.5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: cardList(width * 100, height / 1.3, primaryColor),
              ),
              SizedBox(
                height: height * 2.5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Siswa PKL",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Inter"),
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        "Selengkapnya",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color.fromARGB(255, 40, 119, 255)),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 2.5,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: cardList(width * 100, height / 1.2, primaryColor),
              ),
              SizedBox(
                height: height * 2,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: cardList(width * 100, height / 1.2, primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
