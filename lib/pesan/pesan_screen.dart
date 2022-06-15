import 'package:edulab/contents.dart';
import 'package:flutter/material.dart';

import '../shared/constant.dart';

class PesanScreen extends StatefulWidget {
  const PesanScreen({Key? key}) : super(key: key);

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  @override
  Widget build(BuildContext context) {
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
                    width: Constant(context).width * 0.9,
                    height: Constant(context).height * 0.05,
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
                height: Constant(context).height * 0.03,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: Constant(context).width,
                // height: height * 15,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Row(
                  children: [
                    SizedBox(
                      width: Constant(context).width * 0.03,
                    ),
                    Container(
                      height: Constant(context).height * 0.1,
                      width: Constant(context).width * 0.15,
                      decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(
                      width: Constant(context).width * 0.03,
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
                                fontWeight: FontWeight.w400,
                                color: Colors.grey)),
                      ],
                    ),
                    SizedBox(
                      width: Constant(context).width * 0.35,
                    ),
                    Row(
                      children: [Text("11:11")],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Constant(context).height * 0.015,
              ),
              SizedBox(
                height: Constant(context).height * 0.015,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
