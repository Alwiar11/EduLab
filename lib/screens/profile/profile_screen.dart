import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/resources/models/user_model.dart';
import 'package:edulab/screens/edit_profile/edit_profile.dart';
import 'package:edulab/screens/profile/signout_function.dart';
import 'package:edulab/shared/constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/login.dart';
import '../profile_user/card_profile_user.dart';
import 'card_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Constant(context).height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text(
                                    'Peringatan!',
                                    style: TextStyle(color: Colors.amber),
                                  ),
                                  content: Text("Apakah Anda Yakin?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text(
                                        'Kembali',
                                        style: TextStyle(color: primaryColor),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        SignOut(context).signout();
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()),
                                                (route) => false);
                                      },
                                      child: const Text('OK',
                                          style:
                                              TextStyle(color: primaryColor)),
                                    ),
                                  ],
                                ));
                      },
                      child: Icon(
                        Icons.logout_outlined,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      width: Constant(context).width * 0.03,
                    )
                  ],
                ),
                uid != null
                    ? FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection('users')
                            .doc(uid)
                            .get(),
                        builder: (_, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              height: Constant(context).height * 0.26,
                              width: Constant(context).width * 0.5,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: snapshot.data!.get("profile") != ""
                                      ? DecorationImage(
                                          image: NetworkImage(
                                              snapshot.data!.get("profile")),
                                          fit: BoxFit.cover)
                                      : DecorationImage(
                                          image: AssetImage(
                                              "assets/images/default.png"),
                                          fit: BoxFit.cover),
                                  border: Border.all(
                                      width: 10, color: primaryColor)),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        bool? result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile()));

                        if (result != null) {
                          getUid();
                        }
                      },
                      child: Container(
                        height: Constant(context).height * 0.04,
                        width: Constant(context).width * 0.18,
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
                      width: Constant(context).height * 0.03,
                    )
                  ],
                ),
              ],
            ),
          ),
          uid != null
              ? FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
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

                          CardProfile(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Asal Sekolah',
                              desc: users.school),
                          CardProfile(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Jurusan',
                              desc: users.vacation),
                          CardProfile(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Alamat',
                              desc: users.address),
                          CardProfile(
                              height: Constant(context).height / 100,
                              width: Constant(context).width / 100,
                              title: 'Umur',
                              desc: users.age.toString()),
                          CardProfile(
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
