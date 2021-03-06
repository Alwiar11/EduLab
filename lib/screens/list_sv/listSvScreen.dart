import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';

import 'package:edulab/screens/profile_user/profile_user.dart';

import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListSvScreen extends StatefulWidget {
  const ListSvScreen({Key? key}) : super(key: key);

  @override
  State<ListSvScreen> createState() => _ListSvScreenState();
}

class _ListSvScreenState extends State<ListSvScreen> {
  TextEditingController controller = TextEditingController();
  bool isSearch = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: Constant(context).width * 0.9,
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
                      controller: controller,
                      onChanged: (e) {
                        if (controller.text == '') {
                          setState(() {
                            isSearch = false;
                          });
                        }
                        setState(() {
                          isSearch = true;
                        });
                        if (controller.text != e) {
                          controller.text = e;
                        }
                      },
                      keyboardType: TextInputType.text,
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
                .where("role", isEqualTo: "supervisor")
                .orderBy('endFromDate', descending: true)
                .snapshots(),
            builder: (_, snapshot) {
              if (snapshot.hasData) {
                print(controller.text);
                List<QueryDocumentSnapshot<Object?>> searchItem =
                    snapshot.data!.docs;
                searchItem.retainWhere((element) {
                  String searchName = element.get("name");
                  return searchName
                      .toLowerCase()
                      .contains(controller.text.toLowerCase());
                });
                List<QueryDocumentSnapshot<Object?>> items;
                if (isSearch && searchItem.length > 0) {
                  items = searchItem;
                } else {
                  items = snapshot.data!.docs;
                }
                print(items.first.data());
                return Expanded(
                  child: GridView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.600,
                        crossAxisCount: 2),
                    children: [
                      ...items.map((e) {
                        return CardListPkl(
                          name: e.get("name"),
                          profile: e.get("profile"),
                          school: e.get("school"),
                          uid: e.id,
                          role: e.get('role'),
                        );
                      })
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
  final String role;

  const CardListPkl({
    required this.name,
    required this.profile,
    required this.school,
    required this.uid,
    required this.role,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 400,
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
                      builder: (context) => ProfileUser(
                            uid: uid,
                            role: role,
                          )));
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
