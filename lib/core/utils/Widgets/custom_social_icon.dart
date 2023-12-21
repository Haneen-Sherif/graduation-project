import 'package:flutter/material.dart';

class CustomSocialIcon extends StatelessWidget {
  const CustomSocialIcon({
    super.key,
    required this.onPressed,
    required this.borderColor,
    required this.icon,
    required this.iconColor,
  });

  final void Function() onPressed;
  final Color borderColor;
  final IconData icon;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: 24,
        height: 24,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1.50,
              color: borderColor,
            ),
            borderRadius: BorderRadius.circular(19.50),
          ),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 10,
        ),
      ),
    );
  }
}
