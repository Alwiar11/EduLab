import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';

import 'package:flutter/material.dart';

import '../shared/constant.dart';
import 'card_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                      onTap: () {},
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
                FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc("W3lpN3fdXfAhAXFJgy31")
                        .get(),
                    builder: (_, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: Constant(context).height * 0.26,
                          width: Constant(context).width * 0.5,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data!.get("image"),
                                  ),
                                  fit: BoxFit.fill),
                              border:
                                  Border.all(width: 10, color: primaryColor)),
                        );
                      }
                      return Text("Loading");
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
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
                        height: Constant(context).height * 0.01,
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
                        height: Constant(context).height * 0.02,
                      ),
                      CardProfile(
                          height: Constant(context).height / 100,
                          width: Constant(context).width / 100,
                          title: 'Asal Sekolah',
                          desc: snapshot.data!.get("asal sekolah")),
                      CardProfile(
                          height: Constant(context).height / 100,
                          width: Constant(context).width / 100,
                          title: 'Jurusan',
                          desc: snapshot.data!.get("jurusan")),
                      CardProfile(
                          height: Constant(context).height / 100,
                          width: Constant(context).width / 100,
                          title: 'Alamat',
                          desc: snapshot.data!.get("alamat")),
                      CardProfile(
                          height: Constant(context).height / 100,
                          width: Constant(context).width / 100,
                          title: 'Umur',
                          desc: snapshot.data!.get("umur")),
                      CardProfile(
                          height: Constant(context).height / 100,
                          width: Constant(context).width / 100,
                          title: 'Hobi',
                          desc: snapshot.data!.get("hobi")),
                    ],
                  );
                }
                return Text("Loading");
              }),
        ],
      ),
    );
  }
}
