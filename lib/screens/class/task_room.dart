import 'package:flutter/material.dart';

class TaskRoom extends StatefulWidget {
  const TaskRoom({Key? key}) : super(key: key);

  @override
  State<TaskRoom> createState() => _TaskRoomState();
}

class _TaskRoomState extends State<TaskRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TaskRoom"),
      ),
    );
  }
}
