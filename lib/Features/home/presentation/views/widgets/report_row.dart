import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ReportRow extends StatelessWidget {
  const ReportRow({
    super.key,
    required this.backgroundColor,
    required this.text,
  });

  final Color backgroundColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: backgroundColor,
          radius: 12,
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          text,
          style: Styles.textStyle14(context).copyWith(
            fontFamily: 'Roboto',
          ),
        ),
      ],
    );
  }
}
