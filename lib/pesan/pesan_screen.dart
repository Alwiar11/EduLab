import 'package:edulab/contents.dart';
import 'package:flutter/material.dart';

class PesanScreen extends StatefulWidget {
  const PesanScreen({Key? key}) : super(key: key);

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight / 100;
    final width = screenWidth / 100;
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    width: width * 90,
                    height: height * 5,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 2),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(fontSize: 10),
                          hintText: 'Cari...',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 3,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: screenWidth,
                // height: height * 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 2,
                    ),
                    Container(
                      height: height * 10,
                      width: width * 20,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: width * 1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Rey Mysterio",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text("Dilihat",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey)),
                      ],
                    ),
                    SizedBox(
                      width: width * 32,
                    ),
                    Row(
                      children: [Text("11:11")],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 1.5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: screenWidth,
                // height: height * 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 2,
                    ),
                    Container(
                      height: height * 10,
                      width: width * 20,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: width * 1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Rey Mysterio",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text("Dilihat",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey)),
                      ],
                    ),
                    SizedBox(
                      width: width * 32,
                    ),
                    Row(
                      children: [Text("11:11")],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 1.5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: screenWidth,
                // height: height * 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Row(
                  children: [
                    SizedBox(
                      width: width * 2,
                    ),
                    Container(
                      height: height * 10,
                      width: width * 20,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: width * 1,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Rey Mysterio",
                          style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        Text("Dilihat",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey)),
                      ],
                    ),
                    SizedBox(
                      width: width * 32,
                    ),
                    Row(
                      children: [Text("11:11")],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
