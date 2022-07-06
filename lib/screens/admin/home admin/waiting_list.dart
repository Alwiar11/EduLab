import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/profile_user/profile_user.dart';
import 'package:flutter/material.dart';

class WaitingList extends StatelessWidget {
  const WaitingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text("Wating List"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('isVerified', isEqualTo: false)
              .where('role', isNotEqualTo: 'admin')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: [
                  ...snapshot.data!.docs.map((e) => InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProfileUser(uid: e.id, role: e.get('role'))));
                        },
                        child: CardWaiting(
                            name: e.get('name'),
                            profile: e.get('profile'),
                            userId: e.id),
                      ))
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: CircularProgressIndicator(
                  color: primaryColor,
                )),
              ],
            );
          }),
    );
  }
}

class CardWaiting extends StatelessWidget {
  final String name;
  final String profile;
  final String userId;
  const CardWaiting({
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
                    FirebaseFirestore.instance
                        .collection('users')
                        .doc(userId)
                        .update({'isVerified': true});
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.green,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
