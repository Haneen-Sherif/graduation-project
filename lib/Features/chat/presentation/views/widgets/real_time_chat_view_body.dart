import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/manager/rating_cubit/rating_cubit.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/chat_widget.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class RealTimeChatViewBody extends StatefulWidget {
  const RealTimeChatViewBody(
      {super.key,
      required this.id,
      required this.chatRoomId,
      required this.ownerId});

  final String chatRoomId;
  final String id;
  final String ownerId;
  @override
  State<RealTimeChatViewBody> createState() => _RealTimeChatViewBodyState();
}

class _RealTimeChatViewBodyState extends State<RealTimeChatViewBody>
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
        .doc(widget.chatRoomId)
        .collection('chats')
        .doc(fileName)
        .set({
      'sendby': username,
      'message': '',
      'type': 'img',
      'time': DateTime.now()
    });
    var ref =
        FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");
    var uploadTask;
    try {
      uploadTask = await ref.putFile(imageFile!);
    } catch (error) {
      await _firestore
          .collection('chatroon')
          .doc(widget.chatRoomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;

      return null;
    }

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();
      print(imageUrl);
      await _firestore
          .collection('chatroon')
          .doc(widget.chatRoomId)
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
          .doc(widget.chatRoomId)
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
    double _rating = 1;
    final expertsCubit = BlocProvider.of<ExpertsCubit>(context);

    return SafeArea(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, bottom: 13, top: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                context.pop();
                              },
                              child: Image.asset(Assets.iconsBack)),
                          SizedBox(
                            width: 8,
                          ),
                          FutureBuilder<ExpertsModel>(
                              future: expertsCubit.getExpert(widget.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else {
                                  final expert = snapshot.data!;
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              fit: BoxFit.cover,
                                              expert.personalPhoto!,
                                              height: 50,
                                              width: 50,
                                            ),
                                          ),
                                          StreamBuilder<DocumentSnapshot>(
                                              stream: _firestore
                                                  .collection('users')
                                                  .doc(expert.userName!)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.data != null) {
                                                  return snapshot.data![
                                                              'status'] ==
                                                          "Online"
                                                      ? Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child: Container(
                                                            height: 14,
                                                            width: 14,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xff59CD30),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14)),
                                                          ),
                                                        )
                                                      : Positioned(
                                                          bottom: 0,
                                                          right: 0,
                                                          child: Container(
                                                            height: 14,
                                                            width: 14,
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .transparent,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            14)),
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            expert.userName!,
                                            style: Styles.textStyle14(context)
                                                .copyWith(
                                                    fontFamily: "Open Sans",
                                                    fontWeight: FontWeight.w700,
                                                    color: Color(0xff1E1E1E)),
                                          ),
                                          StreamBuilder<DocumentSnapshot>(
                                              stream: _firestore
                                                  .collection('users')
                                                  .doc(expert.userName!)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                if (snapshot.data != null) {
                                                  return Text(
                                                    snapshot.data!['status'],
                                                    style: Styles.textStyle10(
                                                            context)
                                                        .copyWith(
                                                            fontFamily:
                                                                "Open Sans",
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color: Color(
                                                                0xff1E1E1E)),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              })
                                        ],
                                      ),
                                    ],
                                  );
                                }
                              }),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 24),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  elevation: 0,
                                  backgroundColor: Colors.white,
                                  title: Text(
                                    'Rate this specialist',
                                    style: Styles.textStyle20(context)
                                        .copyWith(color: kPrimaryColor),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      RatingBar.builder(
                                        initialRating: _rating,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 30,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        itemBuilder: (context, _) => Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          setState(() {
                                            _rating = rating;
                                          });
                                        },
                                      ),
                                      SizedBox(height: 32),
                                      Center(
                                        child: CustomButton(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.3,
                                          onPressed: () async {
                                            try {
                                              print(_rating);
                                              print(widget.ownerId);
                                              print(widget.id);

                                              await BlocProvider.of<
                                                      RatingCubit>(context)
                                                  .setRating(
                                                      _rating,
                                                      widget.ownerId,
                                                      widget.id);

                                              await BlocProvider.of<
                                                      RatingCubit>(context)
                                                  .calcRating(widget.id);

                                              print('Rated $_rating');
                                              context.pop();
                                              context.pushReplacement(
                                                  AppRoutes.kHomeView);
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                          text: "Submit",
                                        ),
                                      ),
                                    ],
                                  ),
                                ); // Return your custom RatingDialog widget
                              },
                            );
                          },
                          icon: Icon(
                            Icons.done_outline,
                            color: kPrimaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Flexible(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection('chatroon')
                  .doc(widget.chatRoomId)
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
