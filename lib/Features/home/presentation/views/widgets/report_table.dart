import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/report_row.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ReportTable extends StatelessWidget {
  const ReportTable({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.07,
              ),
              child: Text(
                'Time',
                style: Styles.textStyle14.copyWith(
                  fontFamily: 'Roboto',
                  color: const Color(0xFF94A3B8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Divider(),
            const ReportRow(
              backgroundColor: Color(0xff1E40AF),
              text: "1st week",
            ),
            const SizedBox(
              height: 12,
            ),
            const ReportRow(
              backgroundColor: Color(0xff3B82F6),
              text: "1st week",
            ),
            const SizedBox(
              height: 12,
            ),
            const ReportRow(
              backgroundColor: Color(0xff60A5FA),
              text: "3rd week",
            ),
          ],
        ),
      ),
    );
  }
}
