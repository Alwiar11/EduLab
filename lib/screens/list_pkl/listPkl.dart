import 'package:flutter/material.dart';

import 'listPklScreen.dart';

class ListPkl extends StatefulWidget {
  const ListPkl({Key? key}) : super(key: key);

  @override
  State<ListPkl> createState() => _ListPklState();
}

class _ListPklState extends State<ListPkl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,
              size: 30, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 232, 232, 232),
        title: Text(
          "List PKL",
          style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: "Inter",
              fontWeight: FontWeight.w600),
        ),
      ),
      body: ListPklScreen(),
    );
  }
}
