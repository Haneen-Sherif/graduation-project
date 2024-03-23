import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/chat/presentation/manager/providers/chat_provider.dart';
import 'package:graduation_project/Features/chat/presentation/manager/providers/models_provider.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/chat_widget.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/text_widget.dart';
import 'package:graduation_project/Features/chat/services/services.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';
import 'package:provider/provider.dart';

class ChatViewBody extends StatefulWidget {
  const ChatViewBody({
    super.key,
  });

  @override
  State<ChatViewBody> createState() => _ChatViewBodyState();
}

class _ChatViewBodyState extends State<ChatViewBody> {
  bool _isTyping = false;

  late TextEditingController textEditingController;
  late ScrollController _listScrollController;
  late FocusNode focusNode;

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
    final modelsProvider = Provider.of<ModelsProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        leading: IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: Image.asset(Assets.iconsBack)),
                        title: Text('Chat', style: Styles.textStyle20),
                        trailing: IconButton(
                          onPressed: () async {
                            await Services.showModalSheet(context: context);
                          },
                          icon: const Icon(Icons.more_vert_rounded,
                              color: kPrimaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  top: 25,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(Assets.imagesDocBot),
                    const SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Doc Bot",
                          style: Styles.textStyle16.copyWith(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "online",
                          style: Styles.textStyle12.copyWith(
                            fontFamily: "Roboto",
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Flexible(
            child: ListView.builder(
              controller: _listScrollController,
              itemCount: chatProvider.getChatList.length,
              itemBuilder: (context, index) {
                return ChatWidget(
                  timestamp: DateTime.now(),
                  msg: chatProvider.getChatList[index].msg,
                  chatIndex: chatProvider.getChatList[index].chatIndex,
                );
              },
            ),
          ),
          if (_isTyping) ...[
            const SpinKitThreeBounce(
              color: kPrimaryColor,
              size: 18,
            ),
          ],
          const SizedBox(
            height: 15,
          ),
          Material(
            color: const Color(0xffFEFEFE),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: focusNode,
                      style: const TextStyle(color: Colors.black),
                      controller: textEditingController,
                      onSubmitted: (value) async {
                        await sendMessageFCT(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider,
                        );
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: "Type your message...",
                        hintStyle: Styles.textStyle16.copyWith(
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await sendMessageFCT(
                          modelsProvider: modelsProvider,
                          chatProvider: chatProvider);
                    },
                    icon: Image.asset(Assets.iconsSend),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void scrollListToEND() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT(
      {required ModelsProvider modelsProvider,
      required ChatProvider chatProvider}) async {
    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "You cant send multiple messages at a time",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: TextWidget(
            label: "Please type a message",
          ),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    try {
      String msg = textEditingController.text;
      setState(
        () {
          _isTyping = true;
          chatProvider.addUserMessage(msg: msg);
          textEditingController.clear();
          focusNode.unfocus();
        },
      );
      await chatProvider.sendMessageAndGetAnswers(
        msg: msg,
        chosenModelId: modelsProvider.getCurrentModel,
      );
      setState(() {});
    } catch (error) {
      log("error $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: TextWidget(
            label: error.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        scrollListToEND();
        _isTyping = false;
      });
    }
  }
}
