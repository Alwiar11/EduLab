import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/list_pkl/listPkl.dart';
import 'package:edulab/screens/list_sv/listSv.dart';
import 'package:edulab/screens/profile_user/profile_user.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../resources/models/user_model.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  final double height;
  final double width;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = prefs.getString('uid');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            padding: const EdgeInsets.only(left: 20),
            child: uid != null
                ? Column(
                    children: [
                      SizedBox(
                        height: Constant(context).height * 0.02,
                      ),
                      FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .get(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              UserModel users =
                                  UserModel.fromData(snapshot.data!);
                              return Row(
                                children: [
                                  Container(
                                    width: Constant(context).width * 0.2,
                                    height: Constant(context).height * 0.12,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 5, color: primaryColor),
                                      shape: BoxShape.circle,
                                      image: users.profile != ''
                                          ? DecorationImage(
                                              image: NetworkImage(
                                                users.profile,
                                              ),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/default.png'),
                                              fit: BoxFit.cover),
                                    ),
                                  ),
                                  SizedBox(
                                    width: Constant(context).width * 0.03,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Hai,",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        users.name,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              );
                            }
                            return CircularProgressIndicator(
                              color: primaryColor,
                              strokeWidth: 10,
                            );
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
                      uid != null
                          ? StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("role", isEqualTo: "Supervisor")
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
                                                    height: Constant(context)
                                                            .height *
                                                        0.18,
                                                    width: Constant(context)
                                                            .width *
                                                        0.7,
                                                    decoration: BoxDecoration(
                                                        color: primaryColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: SizedBox(),
                                                          flex: 5,
                                                        ),
                                                        Expanded(
                                                            flex: 30,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  height: Constant(
                                                                              context)
                                                                          .height *
                                                                      0.2,
                                                                  width: Constant(
                                                                              context)
                                                                          .width *
                                                                      0.2,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image: e.get("profile") !=
                                                                            ""
                                                                        ? DecorationImage(
                                                                            image: NetworkImage(e.get(
                                                                                "profile")),
                                                                            fit: BoxFit
                                                                                .cover)
                                                                        : DecorationImage(
                                                                            image:
                                                                                AssetImage("assets/images/default.png"),
                                                                            fit: BoxFit.fill),
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                        Expanded(
                                                            flex: 65,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Text(
                                                                      e.get(
                                                                          'name'),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      bottom:
                                                                          10),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceEvenly,
                                                                    children: [
                                                                      Text(
                                                                        e.get(
                                                                            'job'),
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: [
                                                                    Container(
                                                                      width: Constant(context)
                                                                              .width *
                                                                          0.25,
                                                                      height: Constant(context)
                                                                              .height *
                                                                          0.035,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors
                                                                              .white,
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileUser(uid: e.id)));
                                                                            },
                                                                            child:
                                                                                Text(
                                                                              "Lihat",
                                                                              style: TextStyle(fontWeight: FontWeight.w500),
                                                                              textAlign: TextAlign.center,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ))
                                                      ],
                                                    )),
                                                SizedBox(
                                                  width:
                                                      Constant(context).width *
                                                          0.05,
                                                )
                                              ],
                                            )),
                                      ],
                                    ),
                                  );
                                }
                                return CircularProgressIndicator();
                              })
                          : CircularProgressIndicator(),
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
                            Icon(Icons.work_outline,
                                size: 50, color: Colors.white)
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
                              .where("role", isEqualTo: "pkl")
                              .limit(2)
                              .snapshots(),
                          builder: (_, snapshot) {
                            // String name = snapshot.data!.docs[0]['name'];
                            if (snapshot.hasData) {
                              // for (var i = 0;
                              //     i < snapshot.data!.docs.length;
                              //     i++) {
                              //   print(snapshot.data!.docs[i]['name']);
                              // }

                              return Column(
                                children: [
                                  ...snapshot.data!.docs.map(
                                    (e) => Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 20),
                                          height:
                                              Constant(context).height * 0.13,
                                          width: Constant(context).width * 1,
                                          decoration: BoxDecoration(
                                              color: primaryColor,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: Constant(context).width *
                                                    0.025,
                                              ),
                                              Container(
                                                height:
                                                    Constant(context).height *
                                                        0.1,
                                                width: Constant(context).width *
                                                    0.18,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: e.get("profile") != ""
                                                      ? DecorationImage(
                                                          image: NetworkImage(
                                                              e.get("profile")),
                                                          fit: BoxFit.cover)
                                                      : DecorationImage(
                                                          image: AssetImage(
                                                              "assets/images/default.png"),
                                                          fit: BoxFit.fill),
                                                ),
                                              ),
                                              SizedBox(
                                                width: Constant(context).width *
                                                    0.04,
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
                                                        e.get('name'),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      )
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(e.get('school'),
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400))
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              Constant(context).height * 0.025,
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
                  )
                : CircularProgressIndicator()),
      ),
    );
  }
}
