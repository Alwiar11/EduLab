import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/contents.dart';

import 'package:edulab/shared/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/constant.dart';

class AddReply extends StatefulWidget {
  final DocumentReference<Map<String, dynamic>> docRefReply;
  const AddReply({required this.docRefReply, Key? key}) : super(key: key);

  @override
  State<AddReply> createState() => _AddReplyState();
}

class _AddReplyState extends State<AddReply> {
  List<String> multipleImages = [];
  List<XFile> multipleImage = [];

  String? uid;
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    uid = prefs.getString('uid');
    name = prefs.getString('name');
    setState(() {});
  }

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Tambah Jawaban",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: widget.docRefReply
              .collection('reply')
              .where('senderId', isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...multipleImage
                              .map(
                                (e) => Container(
                                  margin: EdgeInsets.only(
                                      top: 20, left: 10, right: 10),
                                  height: 220,
                                  width: 210,
                                  color: primaryColor,
                                  child: Image.file(
                                    File(e.path),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                              .toList()
                        ],
                      ),
                    ),
                    Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: InkWell(
                                onTap: () async {
                                  List<XFile>? _images =
                                      await AppImagePicker(context)
                                          .multiImagePicker();
                                  if (_images.isNotEmpty) {
                                    multipleImage += await _images;
                                    setState(() {});
                                  }
                                },
                                child: Icon(Icons.camera_alt_outlined)),
                          ),
                          InkWell(
                            onTap: () async {
                              List<XFile>? _images =
                                  await AppImagePicker(context)
                                      .multiImagePicker();
                              if (_images.isNotEmpty) {
                                multipleImage += await _images;
                                setState(() {});
                              }
                            },
                            child: Text(
                              'Tambahkan Foto',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                          )
                        ],
                      ),
                    )),
                    Container(
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
                                    textInputAction: TextInputAction.newline,
                                    maxLines: null,
                                    controller: controller,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(fontSize: 17),
                                      labelText: 'Jawaban',
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
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: primaryColor),
                        onPressed: () async {
                          List<XFile>? _images = await multipleImage;
                          if (_images.isNotEmpty) {
                            multipleImages = await AppImagePicker(context)
                                .multiImageUploader(_images, uid ?? '');
                            setState(() {});

                            widget.docRefReply.collection('reply').add({
                              'images': FieldValue.arrayUnion(multipleImages),
                              'answer': controller.text,
                              'senderId': uid,
                              'senderName': name,
                              'sendAt': Timestamp.now()
                            });
                          }
                          print(multipleImages);
                          Navigator.of(context).pop();
                        },
                        child: Text('Simpan'))
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
