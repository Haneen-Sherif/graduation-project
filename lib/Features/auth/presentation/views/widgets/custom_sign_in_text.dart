import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomSignInText extends StatelessWidget {
  const CustomSignInText({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.1),
      child: Center(
        child: SizedBox(
          width: width * 0.6,
          child: Text(
            'Welcome back to\nFishShield ',
            textAlign: TextAlign.center,
            style: Styles.textStyle25.copyWith(
              letterSpacing: 1.50,
            ),
          ),
        ),
      ),
    );
  }
}
