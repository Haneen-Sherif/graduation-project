import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomTextCheckEmail extends StatelessWidget {
  const CustomTextCheckEmail({
    super.key,
    required this.email,
  });

  final String email;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'We’ve sent a code to ',
            style: Styles.textStyle16(context).copyWith(
              color: Colors.black.withOpacity(0.699999988079071),
              fontFamily: 'Inter',
            ),
          ),
          TextSpan(
            text: email,
            style: Styles.textStyle16(context).copyWith(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
