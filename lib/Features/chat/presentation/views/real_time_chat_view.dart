import 'package:flutter/material.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/real_time_chat_view_body.dart';

class RealTimeChatView extends StatelessWidget {
  const RealTimeChatView({
    super.key,
    required this.id,
    required this.name,
    required this.ownerId,
  });

  final String id;
  final String name;
  final String ownerId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: RealTimeChatViewBody(
        id: id,
        chatRoomId: name,
        ownerId: ownerId,
      ),
    );
  }
}
