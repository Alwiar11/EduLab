import 'package:edulab/contents.dart';

import 'package:edulab/screens/chat/contact/contact.dart';
import 'package:edulab/shared/constant.dart';

import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Pesan",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Contact())));
              },
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
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
              InkWell(
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => RoomChat()));
                },
                child: Container(
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
