import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/report_chart.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/report_table.dart';

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
        const Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: ReportChart(),
        ))
      ],
    );
  }
}
