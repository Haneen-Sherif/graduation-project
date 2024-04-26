import 'package:flutter/material.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  GlobalKey<ScaffoldState> chatKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: chatKey,
        drawer: const CustomDrawer(),
        backgroundColor: const Color(0xffF4F4F4),
        body: const ChatViewBody(),
      ),
    );
  }
}
