import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/chat_widget.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class RealTimeChatViewBody extends StatefulWidget {
  const RealTimeChatViewBody({super.key, required this.id});

  final String id;
  @override
  State<RealTimeChatViewBody> createState() => _RealTimeChatViewBodyState();
}

class _RealTimeChatViewBodyState extends State<RealTimeChatViewBody> {
  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;

  List messages = [
    {
      'msg': "Hi there, I'm interested in ordering some food for delivery.",
      'chatIndex': 1,
    },
    {
      'msg':
          "I'm thinking about getting a large pepperoni pizza and some garlic bread. ",
      'chatIndex': 0,
    },
    {
      'msg': "How long will it take for delivery?",
      'chatIndex': 0,
    },
    {
      'msg':
          "We can have that ready for you in about 30-40 minutes. Would you like to proceed with the order?",
      'chatIndex': 1,
    },
    {
      'msg': "Yes, that sounds great! How much will it be?",
      'chatIndex': 0,
    },
    {
      'msg': "Hi there, I'm interested in ordering some food for delivery.",
      'chatIndex': 1,
    },
    {
      'msg':
          "I'm thinking about getting a large pepperoni pizza and some garlic bread. ",
      'chatIndex': 0,
    },
    {
      'msg': "How long will it take for delivery?",
      'chatIndex': 0,
    },
    {
      'msg':
          "We can have that ready for you in about 30-40 minutes. Would you like to proceed with the order?",
      'chatIndex': 1,
    },
    {
      'msg': "Yes, that sounds great! How much will it be?",
      'chatIndex': 0,
    },
  ];

  @override
  void initState() {
    _listScrollController = ScrollController();
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _listScrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(
                                  child: Text('Error: ${snapshot.error}'));
                            } else {
                              final expert = snapshot.data!;
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(70),
                                        child: Image.network(
                                          expert.personalPhoto!,
                                          height: 70,
                                        ),
                                      ),
                                      Positioned(
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
                                      Text(
                                        "online",
                                        style: Styles.textStyle10(context)
                                            .copyWith(
                                                fontFamily: "Open Sans",
                                                fontWeight: FontWeight.w700,
                                                color: Color(0xff1E1E1E)),
                                      )
                                    ],
                                  )
                                ],
                              );
                            }
                          })
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 66,
              )
            ],
          ),
          Flexible(
            child: ListView.builder(
              controller: _listScrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  timestamp: DateTime.now(),
                  msg: messages[index]['msg'],
                  chatIndex: messages[index]['chatIndex'],
                );
              },
            ),
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
                        focusNode: focusNode,
                        style: const TextStyle(color: Colors.black),
                        controller: textEditingController,
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
                      onPressed: () {
                        // await sendMessageFCT(
                        //     modelsProvider: modelsProvider,
                        //     chatProvider: chatProvider);
                      },
                      icon: Image.asset(Assets.iconsUpload),
                    ),
                    IconButton(
                      onPressed: () {
                        // await sendMessageFCT(
                        //     modelsProvider: modelsProvider,
                        //     chatProvider: chatProvider);
                      },
                      icon: Image.asset(Assets.iconsSend),
                    ),
                  ])))
        ],
      ),
    );
  }
}
