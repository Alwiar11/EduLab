import 'package:edulab/contents.dart';
import 'package:edulab/pesan/pesan.dart';
import 'package:edulab/pesan/pesan_screen.dart';
import 'package:flutter/material.dart';

import 'card_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight / 100;
    final width = screenWidth / 100;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: screenWidth,
            height: height * 40,
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.logout_outlined,
                      size: 30,
                    ),
                    SizedBox(
                      width: width * 3,
                    )
                  ],
                ),
                Container(
                  height: height * 26,
                  width: width * 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      border: Border.all(width: 10, color: primaryColor)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: height * 4,
                        width: width * 18,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Edit Akun",
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 3,
                    )
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text("Alwi Aulia Rachman",
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 22,
                        fontWeight: FontWeight.w600)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  "0821XXXXXXXXX",
                  style: TextStyle(
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 129, 129, 129)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Text(
                  "User ID : 12345",
                  style: TextStyle(
                      fontFamily: "Inter",
                      color: Color.fromARGB(255, 129, 129, 129)),
                ),
              ),
              SizedBox(
                height: height * 3,
              ),
              Column(
                children: [
                  CardProfile(
                      height: height,
                      width: width,
                      title: "Asal Sekolah",
                      desc: "SMKN 1 Katapang"),
                  CardProfile(
                      height: height,
                      width: width,
                      title: "Asal Sekolah",
                      desc: "SMKN 1 Katapang"),
                  CardProfile(
                      height: height,
                      width: width,
                      title: "Asal Sekolah",
                      desc: "SMKN 1 Katapang"),
                  CardProfile(
                      height: height,
                      width: width,
                      title: "Asal Sekolah",
                      desc: "SMKN 1 Katapang"),
                  CardProfile(
                      height: height,
                      width: width,
                      title: "Asal Sekolah",
                      desc: "SMKN 1 Katapang"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
