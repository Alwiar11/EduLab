import 'package:flutter/material.dart';

import '../../contents.dart';
import '../../shared/constant.dart';

class CardTask extends StatelessWidget {
  final String title;
  final String post;
  final String taskId;
  const CardTask({
    required this.title,
    required this.post,
    required this.taskId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: Constant(context).width,
      // height: height * 15,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            height: Constant(context).height * 0.1,
            width: Constant(context).width * 0.2,
            decoration: const BoxDecoration(
              color: primaryColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.work_outline_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
          SizedBox(
            width: Constant(context).width * 0.01,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
              Text("Diposting :" + post,
                  style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey)),
            ],
          )
        ],
      ),
    );
  }
}
