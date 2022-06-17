import 'package:flutter/material.dart';

import 'listSvScreen.dart';

class ListSv extends StatefulWidget {
  const ListSv({Key? key}) : super(key: key);

  @override
  State<ListSv> createState() => _ListSvState();
}

class _ListSvState extends State<ListSv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        toolbarHeight: 50,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        title: Text(
          "List Supervisor",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListSvScreen(),
    );
  }
}
