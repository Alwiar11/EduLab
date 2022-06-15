import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/list_pkl/listPkl.dart';
import 'package:edulab/list_sv/listSv.dart';
import 'package:edulab/shared/constant.dart';
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
                height: Constant(context).height * 0.02,
              ),
              FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc("W3lpN3fdXfAhAXFJgy31")
                      .get(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Row(
                        children: [
                          Container(
                            width: Constant(context).width * 0.2,
                            height: Constant(context).height * 0.12,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      snapshot.data!.get("image"),
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                          SizedBox(
                            width: Constant(context).width * 0.02,
                          ),
                          Text(
                            "Hi, " +
                                snapshot.data!.get("nama") +
                                "\nHow Are You?",
                            style: TextStyle(fontSize: 18, fontFamily: "Inter"),
                          ),
                        ],
                      );
                    }
                    return Text("Loading");
                  }),
              SizedBox(
                height: Constant(context).height * 0.025,
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListSv()),
                          );
                        },
                        child: const Text(
                          "Selengkapnya",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromARGB(255, 40, 119, 255)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Constant(context).height * 0.025,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            ...snapshot.data!.docs.map((e) => Row(
                                  children: [
                                    Container(
                                        height: Constant(context).height * 0.18,
                                        width: Constant(context).width * 0.7,
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: Constant(context).width *
                                                  0.025,
                                            ),
                                            Container(
                                              height: Constant(context).height *
                                                  0.15,
                                              width:
                                                  Constant(context).width * 0.2,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          e.get('image')),
                                                      fit: BoxFit.cover)),
                                            ),
                                            SizedBox(
                                              width: Constant(context).height *
                                                  0.02,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      e.get('nama'),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      e.get('role'),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height:
                                                      Constant(context).height *
                                                          0.01,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  const ListSv()),
                                                        );
                                                      },
                                                      child: Container(
                                                        height:
                                                            Constant(context)
                                                                    .height *
                                                                0.03,
                                                        width: Constant(context)
                                                                .width *
                                                            0.2,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15)),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              "Lihat",
                                                              style: TextStyle(
                                                                  color:
                                                                      primaryColor,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                    SizedBox(
                                      width: Constant(context).width * 0.05,
                                    )
                                  ],
                                )),
                          ],
                        ),
                      );
                    }
                    return Text("Loading");
                  }),
              SizedBox(
                height: Constant(context).height * 0.025,
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
                height: Constant(context).height * 0.025,
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                height: Constant(context).height * 0.12,
                width: Constant(context).width * 1,
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  children: [
                    SizedBox(
                      width: Constant(context).width * 0.03,
                    ),
                    Icon(Icons.work_outline, size: 50, color: Colors.white)
                  ],
                ),
              ),
              SizedBox(
                height: Constant(context).height * 0.025,
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
                      child: InkWell(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListPkl()),
                          );
                        }),
                        child: const Text(
                          "Selengkapnya",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromARGB(255, 40, 119, 255)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Constant(context).height * 0.025,
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          ...snapshot.data!.docs.map(
                            (e) => Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  height: Constant(context).height * 0.13,
                                  width: Constant(context).width * 1,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: Constant(context).width * 0.025,
                                      ),
                                      Container(
                                        height: Constant(context).height * 0.1,
                                        width: Constant(context).width * 0.18,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    e.get('image')),
                                                fit: BoxFit.cover)),
                                      ),
                                      SizedBox(
                                        width: Constant(context).width * 0.04,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                e.get('nama'),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(e.get('asal sekolah'),
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Constant(context).height * 0.025,
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }
                    return Text("Loading");
                  })
            ],
          ),
        ),
      ),
    );
  }
}
