import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/report_table.dart';
import 'package:graduation_project/generated/assets.dart';

class ReportWidget extends StatelessWidget {
  const ReportWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ReportTable(size: size),
        Padding(
          padding: EdgeInsets.only(right: size.width * 0.08),
          child: Image.asset(Assets.imagesChart),
        )
      ],
    );
  }
}
