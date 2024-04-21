import 'package:flutter/material.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/real_time_chat_view_body_2.dart';

class RealTimeChatView2 extends StatelessWidget {
  const RealTimeChatView2(
      {super.key, required this.userName, required this.roomName});

  final String userName;
  final String roomName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: RealTimeChatViewBody2(
        farmOwner: userName,
        roomName: roomName,
      ),
    );
  }
}
