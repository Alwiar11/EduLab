import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';

import 'package:flutter/material.dart';

import 'card_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.logout_outlined,
                        size: 30,
                      ),
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
          FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc("W3lpN3fdXfAhAXFJgy31")
                  .get(),
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      SizedBox(
                        height: height * 1,
                      ),
                      Text(snapshot.data!.get("nama"),
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          )),
                      Text(snapshot.data!.get("noHp"),
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text("User Id : " + snapshot.data!.get("id"),
                          style: TextStyle(color: Colors.grey, fontSize: 14)),
                      SizedBox(
                        height: height * 2,
                      ),
                      CardProfile(
                          height: height,
                          width: width,
                          title: 'Asal Sekolah',
                          desc: snapshot.data!.get("asal sekolah")),
                      CardProfile(
                          height: height,
                          width: width,
                          title: 'Jurusan',
                          desc: snapshot.data!.get("jurusan")),
                      CardProfile(
                          height: height,
                          width: width,
                          title: 'Alamat',
                          desc: snapshot.data!.get("alamat")),
                      CardProfile(
                          height: height,
                          width: width,
                          title: 'Umur',
                          desc: snapshot.data!.get("umur")),
                      CardProfile(
                          height: height,
                          width: width,
                          title: 'Hobi',
                          desc: snapshot.data!.get("hobi")),
                    ],
                  );
                }
                return Text("Kosong");
              }),
        ],
      ),
    );
  }
}
