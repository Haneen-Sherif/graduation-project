import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportChart extends StatefulWidget {
  const ReportChart({super.key});

  @override
  State<ReportChart> createState() => _ReportChartState();
}

class _ReportChartState extends State<ReportChart> {
  int activeIndex = -1;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1, child: PieChart(getChartData()));
  }

  PieChartData getChartData() {
    return PieChartData(
        pieTouchData: PieTouchData(
          enabled: true,
          touchCallback: (p0, pieTouchResponse) {
            activeIndex =
                pieTouchResponse?.touchedSection?.touchedSectionIndex ?? -1;
            setState(() {});
          },
        ),
        sectionsSpace: 0,
        sections: [
          PieChartSectionData(
            showTitle: false,
            value: 100/3,
            radius: activeIndex == 0 ? 30 : 20,
            color: const Color(0xFF1E40AF),
          ),
          PieChartSectionData(
            showTitle: false,
            value: 100/3,
            radius: activeIndex == 1 ? 30 : 20,
            color: const Color(0xFF3B82F6),
          ),
          PieChartSectionData(
            showTitle: false,
            value: 100/3,
            radius: activeIndex == 2 ? 30 : 20,
            color: const Color(0xFF60A5FA),
          ),
        ]);
  }
}
