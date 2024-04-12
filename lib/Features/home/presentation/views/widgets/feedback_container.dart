import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/feedback_form.dart';

class FeedbackContainer extends StatelessWidget {
  const FeedbackContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(
            0xffF0EDED,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xffD9D9D9))),
      child: FeedbackForm(),
    );
  }
}
