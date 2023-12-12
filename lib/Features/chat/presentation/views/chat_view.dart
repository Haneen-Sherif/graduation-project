import 'package:flutter/material.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/chat_view_body.dart';
import 'package:graduation_project/Features/chat/services/services.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        title: const Text("Chat"),
        actions: [
          IconButton(
            onPressed: () async {
              await Services.showModalSheet(context: context);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Color(
                0xff1E68D7,
              ),
            ),
          ),
        ],
      ),
      body: const ChatViewBody(),
    );
  }
}
