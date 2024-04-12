import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class DiseaseInfoTitle extends StatelessWidget {
  const DiseaseInfoTitle({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Styles.textStyle16(context).copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 0.96,
      ),
    );
  }
}
