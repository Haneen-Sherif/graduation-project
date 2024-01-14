import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.width,
    required this.text,
    required this.onPressed, this.color,
  });

  final double width;
  final String text;
  final Color? color;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: width,
        height: 48,
        decoration: ShapeDecoration(
          color:color?? kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: Styles.textStyle18.copyWith(
                color:  Color(0xFFFFF9F9),
                letterSpacing: 1.08,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
