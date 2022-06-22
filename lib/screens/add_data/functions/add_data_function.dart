import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddDataFunction {
  final BuildContext context;
  final TextEditingController controllerName;
  final TextEditingController controllerSchool;
  final TextEditingController controllerVacation;
  final TextEditingController controllerAddress;
  final TextEditingController controllerAge;
  final TextEditingController controllerHobby;

  AddDataFunction(
    this.context,
    this.controllerName,
    this.controllerSchool,
    this.controllerVacation,
    this.controllerAddress,
    this.controllerAge,
    this.controllerHobby,
  );
}
