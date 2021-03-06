import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/home/card_sv.dart';
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
                                  uid != null
                                      ? Container(
                                          width: Constant(context).width * 0.2,
                                          height:
                                              Constant(context).height * 0.12,
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
                                                    fit: BoxFit.contain),
                                          ),
                                        )
                                      : CircularProgressIndicator(),
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
                                      SizedBox(
                                        width: 230,
                                        child: Text(
                                          users.name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.ellipsis),
                                        ),
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
                          ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("role", isEqualTo: "supervisor")
                                  .limit(4)
                                  .snapshots(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: <Widget>[
                                        ...snapshot.data!.docs
                                            .map((e) => Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10),
                                                  child: CardSv(
                                                    profile: e.get('profile'),
                                                    name: e.get('name'),
                                                    job: e.get('job'),
                                                    uid: e.id,
                                                    role: e.get('role'),
                                                  ),
                                                ))
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
                      uid != null
                          ? StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .where("role", isEqualTo: "pkl")
                                  .limit(3)
                                  .snapshots(),
                              builder: (_, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    children: [
                                      ...snapshot.data!.docs.map(
                                        (e) => InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProfileUser(
                                                          uid: e.id,
                                                          role: e.get('role'),
                                                        )));
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                margin:
                                                    EdgeInsets.only(right: 20),
                                                height:
                                                    Constant(context).height *
                                                        0.13,
                                                width:
                                                    Constant(context).width * 1,
                                                decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: Constant(context)
                                                              .width *
                                                          0.025,
                                                    ),
                                                    uid != null
                                                        ? Container(
                                                            height: 60,
                                                            width: 60,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              image: e.get(
                                                                          "profile") !=
                                                                      ""
                                                                  ? DecorationImage(
                                                                      image: NetworkImage(
                                                                          e.get(
                                                                              "profile")),
                                                                      fit: BoxFit
                                                                          .cover)
                                                                  : DecorationImage(
                                                                      image: AssetImage(
                                                                          "assets/images/default.png"),
                                                                      fit: BoxFit
                                                                          .contain),
                                                            ),
                                                          )
                                                        : CircularProgressIndicator(),
                                                    SizedBox(
                                                      width: Constant(context)
                                                              .width *
                                                          0.04,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              e.get('name'),
                                                              style: TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                e.get('school'),
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white,
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
                                                    Constant(context).height *
                                                        0.025,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                return CircularProgressIndicator();
                              })
                          : CircularProgressIndicator()
                    ],
                  )
                : CircularProgressIndicator()),
      ),
    );
  }
}
