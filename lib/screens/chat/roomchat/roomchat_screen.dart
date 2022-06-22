import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';

class RoomChatScreen extends StatefulWidget {
  const RoomChatScreen({Key? key}) : super(key: key);

  @override
  State<RoomChatScreen> createState() => _RoomChatScreenState();
}

class _RoomChatScreenState extends State<RoomChatScreen> {
  @override
  Widget build(BuildContext context) {
    return CardChat();
  }
}

class CardChat extends StatelessWidget {
  const CardChat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Test"),
          ],
        )),
        Container(
          height: 50,
          width: Constant(context).width,
          color: primaryColor,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.add_circle,
                      color: Color.fromARGB(255, 187, 187, 187),
                      size: 35,
                    )),
              ),
              Container(
                height: 35,
                width: Constant(context).width * 0.71,
                decoration: BoxDecoration(
                  color: Color.fromARGB(150, 255, 255, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintStyle: TextStyle(fontSize: 17),
                    // hintText: title,

                    border: InputBorder.none,

                    contentPadding:
                        EdgeInsets.only(left: 10, right: 10, bottom: 13),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.send,
                    color: Color.fromARGB(255, 187, 187, 187),
                  ))
            ],
          ),
        )
      ],
    );
  }
}
