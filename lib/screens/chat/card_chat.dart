import 'package:edulab/contents.dart';
import 'package:flutter/material.dart';

import '../../shared/constant.dart';

class CardChat extends StatelessWidget {
  final String name;
  final String profile;
  final String? lastChat;
  final String? lastTime;

  const CardChat({
    required this.name,
    required this.profile,
    this.lastChat,
    this.lastTime,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: Constant(context).width,
        // height: height * 15,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: Row(
          children: [
            SizedBox(
              width: Constant(context).width * 0.03,
            ),
            Container(
              height: Constant(context).height * 0.1,
              width: Constant(context).width * 0.15,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: primaryColor,
                  image: profile != ''
                      ? DecorationImage(
                          image: NetworkImage(profile), fit: BoxFit.cover)
                      : DecorationImage(
                          image: AssetImage('assets/images/default.png'),
                          fit: BoxFit.cover)),
            ),
            SizedBox(
              width: Constant(context).width * 0.03,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Constant(context).width * 0.5,
                  child: Text(
                    name,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontFamily: "Inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(lastChat == null ? '' : lastChat.toString(),
                    style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey)),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [Text(lastTime == null ? '' : lastTime.toString())],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
