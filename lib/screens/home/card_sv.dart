import 'package:flutter/material.dart';

import '../../contents.dart';
import '../../shared/constant.dart';
import '../profile_user/profile_user.dart';

class CardSv extends StatelessWidget {
  final String profile;
  final String name;
  final String job;
  final String uid;
  final String role;
  const CardSv({
    required this.profile,
    required this.name,
    required this.job,
    required this.uid,
    required this.role,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 140,
        width: 315,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(),
              flex: 5,
            ),
            Expanded(
                flex: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: profile != ""
                            ? DecorationImage(
                                image: NetworkImage(profile), fit: BoxFit.cover)
                            : DecorationImage(
                                image: AssetImage("assets/images/default.png"),
                                fit: BoxFit.fill),
                      ),
                    ),
                  ],
                )),
            Expanded(
                flex: 65,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            job,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: Constant(context).width * 0.25,
                          height: Constant(context).height * 0.035,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                                child: Text(
                                  "Lihat",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
