import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/profile_user/profile_user.dart';

import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';

class ListPklScreen extends StatefulWidget {
  const ListPklScreen({Key? key}) : super(key: key);

  @override
  State<ListPklScreen> createState() => _ListPklScreenState();
}

class _ListPklScreenState extends State<ListPklScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final height = screenHeight / 100;
    final width = screenWidth / 100;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: width * 90,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      keyboardType: TextInputType.number,
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
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where("role", isEqualTo: "pkl")
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: GridView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.75,
                        crossAxisCount: 2),
                    children: [
                      ...snapshot.data!.docs.map((e) => CardListPkl(
                          name: e.get("name"),
                          profile: e.get("profile"),
                          school: e.get("school"),
                          uid: e.id))
                    ],
                  ),
                );
              }
              return CircularProgressIndicator();
            })
        //
      ],
    );
  }
}

class CardListPkl extends StatelessWidget {
  final String profile;
  final String name;
  final String school;
  final String uid;

  const CardListPkl({
    required this.name,
    required this.profile,
    required this.school,
    required this.uid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constant(context).width * 0.4,
      height: Constant(context).height * 0.45,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          Container(
            height: Constant(context).height * 0.2,
            width: Constant(context).width * 0.2,
            decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                image: profile != ""
                    ? DecorationImage(
                        image: NetworkImage(profile), fit: BoxFit.cover)
                    : DecorationImage(
                        image: AssetImage("assets/images/default.png"),
                        fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 1),
            child: Text(name),
          ),
          Text(school),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileUser(uid: uid)));
            },
            child: Container(
              width: Constant(context).width * 0.3,
              height: Constant(context).height * 0.04,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Lihat",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
