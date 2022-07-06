import 'package:flutter/material.dart';
import 'package:edulab/contents.dart';

import '../../shared/constant.dart';
import 'label.dart';

class TextFieldEdit extends StatelessWidget {
  final String title;
  final TextInputType keyboardType;
  final TextEditingController controller;

  const TextFieldEdit({
    required this.title,
    required this.controller,
    required this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Column(
        children: [
          Label(
            title: title,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 45,
                  width: Constant(context).width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: TextFormField(
                    maxLength: 40,
                    keyboardType: keyboardType,
                    controller: controller,
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      //

                      border: InputBorder.none,
                      // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
