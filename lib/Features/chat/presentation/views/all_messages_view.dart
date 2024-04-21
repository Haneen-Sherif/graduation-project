import 'package:flutter/material.dart';
import 'package:graduation_project/Features/chat/presentation/views/widgets/all_messages_view_body.dart';

class AllMessagesView extends StatelessWidget {
  const AllMessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F4F4),
      body: AllMessagesViewBody(),
    );
  }
}
