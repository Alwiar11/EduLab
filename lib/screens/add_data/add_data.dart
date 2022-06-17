import 'package:flutter/material.dart';

class AddData extends StatelessWidget {
  final String uid;
  AddData({required this.uid, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  color: Colors.amber,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
