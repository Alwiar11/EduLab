import 'package:edulab/screens/chat/chat_screen.dart';
import 'package:edulab/screens/chat/contact/contact.dart';

import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Pesan",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Contact())));
              },
              icon: Icon(
                Icons.add,
                color: Colors.black,
              ))
        ],
      ),
      body: ChatScreen(),
    );
  }
}
