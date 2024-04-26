import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/chat_widget.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class RealTimeChatViewBody2 extends StatefulWidget {
  const RealTimeChatViewBody2(
      {super.key, required this.farmOwner, required this.roomName});

  final String farmOwner;
  final String roomName;
  @override
  State<RealTimeChatViewBody2> createState() => _RealTimeChatViewBody2State();
}

class _RealTimeChatViewBody2State extends State<RealTimeChatViewBody2>
    with WidgetsBindingObserver {
  late TextEditingController _message;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String username = '';
  File? imageFile;

  Future<String> getName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final name = await prefs.getString('username');

    username = name!;
    print("username: $username");
    return username;
  }

  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) async {
      if (xFile != null) {
        imageFile = File(xFile.path);
        await uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;
    try {
      await _firestore
          .collection('chatroon')
          .doc(widget.roomName)
          .collection('chats')
          .doc(fileName)
          .set({
        'sendby': username,
        'message': '',
        'type': 'img',
        'time': FieldValue.serverTimestamp()
      });
    } catch (e) {
      print(e);
    }
    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");
    var uploadTask;
    try {
      uploadTask = await ref.putFile(imageFile!);
    } catch (error) {
      await _firestore
          .collection('chatroon')
          .doc(widget.roomName)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;

      return null;
    }

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      print(imageUrl);
      try {
        await _firestore
            .collection('chatroon')
            .doc(widget.roomName)
            .collection('chats')
            .doc(fileName)
            .update({
          'message': imageUrl,
        });
      } catch (e) {
        print(e);
      }

      try {
        await _firestore.collection('users').doc(username).update(
            {'message': _message.text, 'type': 'img', 'time': DateTime.now()});
      } catch (e) {
        print(e);
      }
    }
  }

  void onSendMessage() async {
    if (_message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        'sendby': username,
        'message': _message.text,
        'type': 'text',
        'time': DateTime.now()
      };
      print("messange sent successfully");
      await _firestore
          .collection('chatroon')
          .doc(widget.roomName)
          .collection('chats')
          .add(messages);

      await _firestore.collection('users').doc(username).update(
          {'message': _message.text, 'type': 'text', 'time': DateTime.now()});

      _message.clear();
      _listScrollController.animateTo(0,
          duration: Duration(microseconds: 500), curve: Curves.fastOutSlowIn);
    } else {
      print("Enter Some Text");
    }
  }

  late ScrollController _listScrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    getName();
    _listScrollController = ScrollController();
    _message = TextEditingController();
    focusNode = FocusNode();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
    super.initState();
  }

  void setStatus(String status) async {
    await _firestore
        .collection('users')
        .doc(username)
        .update({'status': status});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
    } else {
      setStatus("Offline");
    }
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    _message.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 13, top: 13),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: Image.asset(Assets.iconsBack)),
                  SizedBox(
                    width: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          // ClipRRect(
                          //   borderRadius: BorderRadius.circular(50),
                          //   child: Image.network(
                          //     fit: BoxFit.fill,
                          //     expert.personalPhoto!,
                          //     height: 50,
                          //     width: 50,
                          //   ),
                          // ),
                          StreamBuilder<DocumentSnapshot>(
                              stream: _firestore
                                  .collection('users')
                                  .doc(widget.farmOwner)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return snapshot.data!['status'] == "Online"
                                      ? Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            height: 14,
                                            width: 14,
                                            decoration: BoxDecoration(
                                                color: Color(0xff59CD30),
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                          ),
                                        )
                                      : Positioned(
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            height: 14,
                                            width: 14,
                                            decoration: BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius:
                                                    BorderRadius.circular(14)),
                                          ),
                                        );
                                } else {
                                  return Container();
                                }
                              })
                        ],
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: 13,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.farmOwner,
                            style: Styles.textStyle14(context).copyWith(
                                fontFamily: "Open Sans",
                                fontWeight: FontWeight.w700,
                                color: Color(0xff1E1E1E)),
                          ),
                          StreamBuilder<DocumentSnapshot>(
                              stream: _firestore
                                  .collection('users')
                                  .doc(widget.farmOwner)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                    snapshot.data!['status'],
                                    style: Styles.textStyle10(context).copyWith(
                                        fontFamily: "Open Sans",
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xff1E1E1E)),
                                  );
                                } else {
                                  return Container();
                                }
                              })
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroon')
                  .doc(widget.roomName)
                  .collection('chats')
                  .orderBy('time', descending: true)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('Firestore error: ${snapshot.error}');
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('Waiting for Firestore data...');
                  return CircularProgressIndicator(
                    color: kPrimaryColor,
                  );
                }

                print('Number of documents: ${snapshot.data!.docs.length}');

                snapshot.data!.docs.forEach((doc) {
                  print('Document ID: ${doc.id}');
                  print('Data: ${doc.data()}');
                });
                if (snapshot.data != null) {
                  return ListView.builder(
                    reverse: true,
                    controller: _listScrollController,
                    itemBuilder: (context, index) {
                      print(Text(snapshot.data!.docs[index]['message']));
                      return ChatWidget(
                        imageMessage: snapshot.data!.docs[index]['message'],
                        type: snapshot.data!.docs[index]['type'],
                        timestamp: snapshot.data!.docs[index]['time'].toDate(),
                        msg: snapshot.data!.docs[index]['message'],
                        chatIndex:
                            snapshot.data!.docs[index]['sendby'] == username
                                ? 0
                                : 1,
                      );
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                } else {
                  print("======================");
                  return Container();
                }
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Material(
            color: const Color(0xffFEFEFE),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    onSubmitted: (value) {
                      return onSendMessage();
                    },
                    focusNode: focusNode,
                    style: const TextStyle(color: Colors.black),
                    controller: _message,
                    decoration: InputDecoration.collapsed(
                      hintText: "Type your message...",
                      hintStyle: Styles.textStyle16(context).copyWith(
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => getImage(),
                  icon: Image.asset(Assets.iconsUpload),
                ),
                IconButton(
                  onPressed: onSendMessage,
                  icon: Image.asset(Assets.iconsSend),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
