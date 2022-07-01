import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';
import 'package:edulab/screens/class/task_room.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../shared/constant.dart';

class AddTask extends StatefulWidget {
  final String? classId;
  final DocumentReference<Map<String, dynamic>>? docRef;
  const AddTask({this.classId, this.docRef, Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  DateTime dateTime = DateTime.now();

  selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      dateTime = picked;
      //assign the chosen date to the controller
      controllerEndedAt.text = DateFormat('EEE d MMM y').format(dateTime);
    }
  }

  TextEditingController controllerTitle = TextEditingController();
  TextEditingController controllerSubtitle = TextEditingController();
  TextEditingController controllerEndedAt = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        title: Text("Tambah Tugas"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: widget.docRef == null
              ? FirebaseFirestore.instance
                  .collection('class')
                  .doc(widget.classId)
                  .collection('task')
                  .snapshots()
              : widget.docRef!.collection('task').snapshots(),
          builder: (_, snapshots) {
            if (snapshots.hasData) {
              CollectionReference<Map<String, dynamic>> collRefTaskRoom =
                  FirebaseFirestore.instance
                      .collection('class')
                      .doc(widget.classId)
                      .collection('task');
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Center(
                        child: TextFieldTask(
                          controller: controllerTitle,
                          icon: Icon(
                            Icons.label,
                            color: primaryColor,
                          ),
                          title: 'Judul Tugas',
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 3),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Container(
                                      height: 150,
                                      width: Constant(context).width * 0.9,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: TextFormField(
                                        keyboardType: TextInputType.multiline,
                                        textInputAction:
                                            TextInputAction.newline,
                                        maxLines: null,
                                        controller: controllerSubtitle,
                                        decoration: InputDecoration(
                                          prefixIcon: Icon(
                                            Icons.label,
                                            color: primaryColor,
                                          ),
                                          hintStyle: TextStyle(fontSize: 17),
                                          hintText: 'Deskripsi',

                                          border: InputBorder.none,
                                          // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                          contentPadding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 10,
                                              top: 10),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Container(
                            height: 45,
                            width: Constant(context).width * 0.9,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(1),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              onTap: selectDate,
                              readOnly: true,
                              controller: controllerEndedAt,
                              decoration: InputDecoration(
                                hintStyle: TextStyle(fontSize: 17),
                                // hintText: title,
                                labelText: 'Masa Tenggat',
                                prefixIcon: Icon(
                                  Icons.timer,
                                  color: primaryColor,
                                ),

                                labelStyle: TextStyle(
                                    color: primaryColor, fontSize: 16),
                                border: InputBorder.none,
                                // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style:
                              ElevatedButton.styleFrom(primary: primaryColor),
                          onPressed: () {
                            print(widget.classId);
                            print(widget.docRef);

                            FirebaseFirestore.instance
                                .collection('class')
                                .doc(widget.classId)
                                .collection('task')
                                .add({
                              'title': controllerTitle.text,
                              'subtitle': controllerSubtitle.text,
                              'createdAt': Timestamp.now(),
                              'endedAt': Timestamp.fromDate(dateTime)
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text("Simpan"),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}

class TextFieldTask extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Icon icon;
  const TextFieldTask({
    required this.title,
    required this.controller,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Container(
        height: 45,
        width: Constant(context).width * 0.9,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 17),
            // hintText: title,
            labelText: title,
            prefixIcon: icon,

            labelStyle: TextStyle(color: primaryColor, fontSize: 16),
            border: InputBorder.none,
            // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          ),
        ),
      ),
    );
  }
}
