import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
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
  late BuildContext dContext;

  String? uid;
  String? name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
    dContext = context;
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
    print(name);
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
                                  showGeneralDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    barrierLabel: '',
                                    transitionDuration:
                                        Duration(milliseconds: 100),
                                    pageBuilder:
                                        (context, animation1, animation2) {
                                      dContext = context;
                                      return Container();
                                    },
                                    transitionBuilder:
                                        (BuildContext context, a1, a2, widget) {
                                      dContext = context;
                                      return WillPopScope(
                                        onWillPop: () async => false,
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    },
                                  );
                                  List<XFile>? _images =
                                      await AppImagePicker(context)
                                          .multiImagePicker();
                                  if (_images.isNotEmpty) {
                                    multipleImage += await _images;
                                    setState(() {});
                                  }
                                  List<XFile>? _images1 = await multipleImage;
                                  if (_images.isNotEmpty) {
                                    multipleImages =
                                        await AppImagePicker(context)
                                            .multiImageUploader(
                                                _images1, uid ?? '');
                                    setState(() {});
                                  }
                                  Navigator.of(dContext).pop();
                                },
                                child: Icon(Icons.camera_alt_outlined)),
                          ),
                          InkWell(
                            onTap: () async {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: false,
                                barrierLabel: '',
                                transitionDuration: Duration(milliseconds: 100),
                                pageBuilder: (context, animation1, animation2) {
                                  dContext = context;
                                  return Container();
                                },
                                transitionBuilder:
                                    (BuildContext context, a1, a2, widget) {
                                  dContext = context;
                                  return WillPopScope(
                                    onWillPop: () async => false,
                                    child: Center(
                                        child: CircularProgressIndicator()),
                                  );
                                },
                              );
                              List<XFile>? _images =
                                  await AppImagePicker(context)
                                      .multiImagePicker();
                              if (_images.isNotEmpty) {
                                multipleImage += await _images;
                                setState(() {});
                              }
                              List<XFile>? _images1 = await multipleImage;
                              if (_images.isNotEmpty) {
                                multipleImages = await AppImagePicker(context)
                                    .multiImageUploader(_images1, uid ?? '');
                                setState(() {});
                              }
                              Navigator.of(dContext).pop();
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
                          showDialog(
                              context: context,
                              builder: (BuildContext ctx) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: Text(
                                      'Peringatan!',
                                      style: TextStyle(color: Colors.amber),
                                    ),
                                    content: Text("Apakah Anda Yakin?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(ctx, 'Cancel'),
                                        child: const Text(
                                          'Kembali',
                                          style: TextStyle(color: primaryColor),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          Navigator.of(ctx).pop();
                                          if (controller.text.isNotEmpty) {
                                            widget.docRefReply
                                                .collection('reply')
                                                .add({
                                              'answer': controller.text,
                                              'images': FieldValue.arrayUnion(
                                                  multipleImages),
                                              'senderId': uid,
                                              'senderName': name,
                                              'sendAt': Timestamp.now()
                                            });
                                            Navigator.of(context).pop();
                                          } else
                                            await Flushbar(
                                              backgroundColor: Colors.red,
                                              title: 'Tidak Boleh Kosong',
                                              flushbarPosition:
                                                  FlushbarPosition.TOP,
                                              duration: Duration(seconds: 2),
                                              message: 'Harus Terisi Semua',
                                            ).show(context);
                                        },
                                        child: const Text('OK',
                                            style:
                                                TextStyle(color: primaryColor)),
                                      ),
                                    ],
                                  ));
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
