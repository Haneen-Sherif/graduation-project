import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({
    super.key,
    required this.width,
    required this.text,
  });

  final double width;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Styles.textStyle14(context).copyWith(
              color: Colors.black.withOpacity(0.78),
              letterSpacing: 0.84,
            ),
          ),
        ),
        Expanded(
          child: Container(
            decoration: const ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.50,
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
