import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class DetectButton extends StatelessWidget {
  const DetectButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
    this.width,
    required this.myWidget,
    required this.space,
  });

  final double? width;
  final String text;
  final Color? color;
  final void Function() onPressed;
  final Widget myWidget;
  final double space;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        width: width,
        height: 48,
        decoration: ShapeDecoration(
          color: color ?? kPrimaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(35),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: space,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: Styles.textStyle18(context).copyWith(
                  color: const Color(0xFFFFF9F9),
                  letterSpacing: 1.08,
                ),
              ),
            ),
            SizedBox(
              child: myWidget,
            )
          ],
        ),
      ),
    );
  }
}
