import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  // final Map<String, dynamic> userMap;
  final String farmOwner;
  final String roomName;
  @override
  State<RealTimeChatViewBody2> createState() => _RealTimeChatViewBody2State();
}

class _RealTimeChatViewBody2State extends State<RealTimeChatViewBody2>
    with WidgetsBindingObserver {
  late TextEditingController _message;
  // late _controller = ScrollController();

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
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;
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
    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");
    var uploadTask;
    try {
      uploadTask = await ref.putFile(imageFile!);
      // Handle success if needed
    } catch (error) {
      // Handle error
      await _firestore
          .collection('chatroon')
          .doc(widget.roomName)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;

      return null;
    }

    // var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
    //   await _firestore
    //       .collection('chatroon')
    //       .doc(widget.chatRoomId)
    //       .collection('chats')
    //       .doc(fileName)
    //       .delete();
    //   status = 0;
    // });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      print(imageUrl);
      await _firestore
          .collection('chatroon')
          .doc(widget.roomName)
          .collection('chats')
          .doc(fileName)
          .update({
        'message': imageUrl,
      });

      await _firestore.collection('users').doc(username).update(
          {'message': _message.text, 'type': 'img', 'time': DateTime.now()});
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

      // if (messages['sendby'] != username) {
      //   await _firestore.collection('chatroon').doc(widget.roomName).update({
      //     'lastMessage': _message.text,
      //     'unreadCount': FieldValue.increment(1),
      //   });
      // }
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
    // final expertsCubit = BlocProvider.of<ExpertsCubit>(context);

    return SafeArea(
      child: Column(
        children: [
          Text('Chat with ${widget.farmOwner}'),
          SizedBox(
            height: 66,
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

                // Print the number of documents returned by the query
                print('Number of documents: ${snapshot.data!.docs.length}');

                // Print each document's data
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
                      // return Text(snapshot.data!.docs[index]['message']);
                    },
                    itemCount: snapshot.data!.docs.length,
                  );
                } else {
                  print("======================");
                  return Container();
                }
              },
            ),
            // child: ListView.builder(
            //   controller: _listScrollController,
            //   itemCount: messages.length,
            //   itemBuilder: (context, index) {
            //     return ChatWidget(
            //       timestamp: DateTime.now(),
            //       msg: messages[index]['msg'],
            //       chatIndex: messages[index]['chatIndex'],
            //     );
            //   },
            // ),
          ),
          // if (_isTyping) ...[
          //   const SpinKitThreeBounce(
          //     color: kPrimaryColor,
          //     size: 18,
          //   ),
          // ],
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
                        onSubmitted: (value) {
                          return onSendMessage();
                        },
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.black),
                        controller: _message,
                        // onSubmitted: (value) async {
                        //   await sendMessageFCT(
                        //     modelsProvider: modelsProvider,
                        //     chatProvider: chatProvider,
                        //   );
                        // },
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
                  ])))
        ],
      ),
    );
  }
}