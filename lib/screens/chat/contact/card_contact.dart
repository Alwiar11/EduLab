import 'package:edulab/contents.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';

class CardContact extends StatelessWidget {
  final String profile;
  final String name;
  final String uid;
  // final String lastChat;
  const CardContact({
    required this.name,
    required this.profile,
    required this.uid,
    // required this.lastChat,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Constant(context).width,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        children: [
          Container(
            width: 80,
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: profile != ""
                      ? DecorationImage(
                          image: NetworkImage(profile), fit: BoxFit.fitHeight)
                      : DecorationImage(
                          image: AssetImage("assets/images/default.png"),
                          fit: BoxFit.cover)),
            ),
          ),
          SizedBox(
            width: Constant(context).width * 0.5,
            child: Text(
              name,
              style: TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
            ),
          ),
        ],
      ),
    );
  }
}
