import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class AnotherOption extends StatelessWidget {
  const AnotherOption({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });

  final String text1;
  final String text2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Text.rich(
          TextSpan(
            text: text1,
            style: Styles.textStyle14(context).copyWith(
              color: Colors.black.withOpacity(0.78),
              letterSpacing: 0.84,
            ),
            children: <InlineSpan>[
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = onTap,
                text: text2,
                style: Styles.textStyle14(context).copyWith(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.84,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
