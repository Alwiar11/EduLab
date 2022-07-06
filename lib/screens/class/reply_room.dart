import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edulab/shared/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReplyRoom extends StatefulWidget {
  final DocumentReference<Map<String, dynamic>> docRefReply;
  final String replyId;
  const ReplyRoom({required this.docRefReply, required this.replyId, Key? key})
      : super(key: key);

  @override
  State<ReplyRoom> createState() => _ReplyRoomState();
}

class _ReplyRoomState extends State<ReplyRoom> {
  TextEditingController controller = TextEditingController();

  String formattedDate(timeStamp) {
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat(' EEE d MMM hh:mm').format(dateFromTimeStamp);
  }

  String? uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUid();
  }

  getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    uid = await prefs.getString('uid');
    await widget.docRefReply
        .collection('reply')
        .doc(widget.replyId)
        .get()
        .then((doc) {
      controller = TextEditingController(text: doc.get('answer'));
    });

    setState(() {});
  }

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
          "Jawaban",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: widget.docRefReply
            .collection('reply')
            .doc(widget.replyId)
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
                      children: List.generate(
                          snapshot.data!.data()!['images'].length, (index) {
                        return Container(
                          margin: EdgeInsets.only(top: 20, left: 5, right: 5),
                          height: 220,
                          width: 170,
                          child: ClipRRect(
                            child: Image.network(
                              snapshot.data!.data()!['images'][index],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(formattedDate(snapshot.data!.get('sendAt'))),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                height: 150,
                                width: Constant(context).width * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  maxLines: null,
                                  controller: controller,
                                  decoration: InputDecoration(
                                    hintStyle: TextStyle(fontSize: 17),

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
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
