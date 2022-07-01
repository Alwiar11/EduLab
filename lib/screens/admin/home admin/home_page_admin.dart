import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/admin/home%20admin/change_role.dart';
import 'package:edulab/screens/admin/home%20admin/waiting_list.dart';
import 'package:edulab/screens/profile/profile.dart';
import 'package:edulab/screens/profile_user/profile_user.dart';

import 'package:flutter/material.dart';

import '../profile_user_admin_sv/profile_user_admin.dart';
import 'non_active.dart';

class HomePageAdmin extends StatelessWidget {
  const HomePageAdmin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => NonActive()));
              },
              icon: Icon(
                Icons.update_disabled_rounded,
                color: Colors.black,
              )),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              "Supervisor",
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WaitingList()));
                },
                icon: Icon(
                  Icons.add_box_outlined,
                  color: Colors.black,
                ))
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('role', isEqualTo: 'supervisor')
                .snapshots(),
            builder: (_, snapshots) {
              if (snapshots.hasData) {
                return ListView.builder(
                    itemCount: snapshots.data!.size,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => ProfileUserAdminSv(
                                    uid: snapshots.data!.docs[index].id,
                                  )));
                        },
                        child: CardAdmin(
                          name: snapshots.data!.docs[index]['name'],
                          profile: snapshots.data!.docs[index]['profile'],
                          userId: snapshots.data!.docs[index].id,
                        ),
                      );
                    });
              }
              return CircularProgressIndicator();
            }));
  }
}

class CardAdmin extends StatelessWidget {
  final String name;
  final String profile;
  final String userId;
  const CardAdmin({
    required this.name,
    required this.profile,
    required this.userId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: double.infinity,
      height: 65,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15),
            height: 50,
            width: 50,
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
          )),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChangeRole(classId: userId)));
                  },
                  icon: Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 140, 140, 140),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
