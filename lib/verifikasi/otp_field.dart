import 'package:flutter/material.dart';

Container otp(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.shortestSide * 0.13,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
      color: Colors.white,
      shape: BoxShape.rectangle,
    ),
    child: AspectRatio(
      aspectRatio: 1,
      child: TextField(
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        style: const TextStyle(),
        maxLines: 1,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    ),
  );
}
