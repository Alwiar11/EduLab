import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/resources/models/user_model.dart';

import 'package:edulab/screens/profile_user/card_profile_user.dart';
import 'package:edulab/shared/constant.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import '../add_supervisor.dart';
import '../add_supervisor_2.dart';

class ProfileUserAdminSvScreen extends StatefulWidget {
  final String uid;
  const ProfileUserAdminSvScreen({required this.uid, Key? key})
      : super(key: key);

  @override
  State<ProfileUserAdminSvScreen> createState() =>
      _ProfileUserAdminSvScreenState();
}

class _ProfileUserAdminSvScreenState extends State<ProfileUserAdminSvScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: Constant(context).width,
            height: Constant(context).height * 0.4,
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35))),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: Constant(context).height * 0.03,
                ),
                Positioned(
                  left: 0,
                  top: MediaQuery.of(context).viewPadding.top,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                      )),
                ),
                widget.uid != null
                    ? FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.uid)
                            .get(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              // margin: EdgeInsets.only(bottom: 27),
                              height: Constant(context).height * 0.26,
                              width: Constant(context).width * 0.5,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 10, color: primaryColor),
                                  image: snapshot.data!.get("profile") != ""
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data!.get("profile")),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: AssetImage(
                                              "assets/images/default.png"),
                                          fit: BoxFit.cover)),
                            );
                          }
                          return CircularProgressIndicator(
                            color: primaryColor,
                            strokeWidth: 10,
                          );
                        })
                    : CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 10,
                      ),
              ],
            ),
          ),
          widget.uid != null
              ? StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.uid)
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      UserModel users = UserModel.fromData(snapshot.data!);
                      return Column(
                        children: [
                          SizedBox(
                            height: Constant(context).height * 0.01,
                          ),
                          Text(users.name,
                              style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              )),
                          Text(users.phoneNumber,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),
                          Text(users.id,
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 14)),

                          // Text("User Id : " + snapshot.data!.get("id"),
                          //     style: TextStyle(color: Colors.grey, fontSize: 14)),

                          SizedBox(
                            height: Constant(context).height * 0.02,
                          ),
                          CardProfileUser(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Role',
                              desc: users.role),
                          CardProfileUser(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Asal Sekolah',
                              desc: users.school),
                          CardProfileUser(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Jurusan',
                              desc: users.vacation),
                          CardProfileUser(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Alamat',
                              desc: users.address),
                          CardProfileUser(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Umur',
                              desc: users.age.toString()),
                          CardProfileUser(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Hobi',
                              desc: users.hobby),
                        ],
                      );
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                        ),
                        CircularProgressIndicator(
                          color: primaryColor,
                          strokeWidth: 10,
                        )
                      ],
                    );
                  })
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    CircularProgressIndicator()
                  ],
                )
        ],
      ),
    );
  }
}

class CardSv extends StatelessWidget {
  final String name;
  final String profile;
  final String userId;
  const CardSv({
    required this.name,
    required this.profile,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(left: 20, right: 20, top: 3),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
              image: profile != ""
                  ? DecorationImage(
                      image: NetworkImage(profile), fit: BoxFit.cover)
                  : DecorationImage(
                      image: AssetImage("assets/images/default.png"),
                      fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(name),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    print(userId);
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddPkl(userId: userId)));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .update({'pkl1': ''});
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 243, 44, 30),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

class CardSv2 extends StatelessWidget {
  final String name;
  final String profile;
  final String userId;
  const CardSv2({
    required this.name,
    required this.profile,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.only(left: 20, right: 20, top: 3),
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: primaryColor,
              image: profile != ""
                  ? DecorationImage(
                      image: NetworkImage(profile), fit: BoxFit.cover)
                  : DecorationImage(
                      image: AssetImage("assets/images/default.png"),
                      fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(name),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddPkl2(userId: userId)));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: primaryColor,
                  )),
              IconButton(
                  onPressed: () {
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .update({'pkl2': ''});
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Color.fromARGB(255, 243, 44, 30),
                  ))
            ],
          )
        ],
      ),
    );
  }
}
