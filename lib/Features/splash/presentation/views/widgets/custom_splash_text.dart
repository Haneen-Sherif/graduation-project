import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomSplashText extends StatelessWidget {
  const CustomSplashText({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.7,
      child: Text(
        "safeguard aquatic environments by providing early detection and proactive monitoring of fish diseases",
        style: Styles.textStyle14.copyWith(
          color: Colors.black.withOpacity(0.78),
          letterSpacing: 0.84,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}