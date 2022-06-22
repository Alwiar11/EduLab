import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/resources/models/user_model.dart';
import 'package:edulab/screens/edit_profile/edit_profile.dart';
import 'package:edulab/screens/profile_sv/card_profile_sv.dart';
import 'package:edulab/shared/constant.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePklScreen extends StatefulWidget {
  final String uid;
  const ProfilePklScreen({required this.uid, Key? key}) : super(key: key);

  @override
  State<ProfilePklScreen> createState() => _ProfilePklScreenState();
}

class _ProfilePklScreenState extends State<ProfilePklScreen> {
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
                                              snapshot.data!.get("profile")))
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
              ? FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.uid)
                      .get(),
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
                          // Text("User Id : " + snapshot.data!.get("id"),
                          //     style: TextStyle(color: Colors.grey, fontSize: 14)),
                          SizedBox(
                            height: Constant(context).height * 0.02,
                          ),
                          CardProfileSv(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Asal Sekolah',
                              desc: users.school),
                          CardProfileSv(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Jurusan',
                              desc: users.vacation),
                          CardProfileSv(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Alamat',
                              desc: users.address),
                          CardProfileSv(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Umur',
                              desc: users.age.toString()),
                          CardProfileSv(
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
