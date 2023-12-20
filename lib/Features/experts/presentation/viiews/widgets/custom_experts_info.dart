import 'package:flutter/material.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomExpertsInfo extends StatelessWidget {
  const CustomExpertsInfo({
    super.key,
    required this.expertsList,
    required this.index, required this.title, required this.subTitle,
  });

  final List<ExpertsModel> expertsList;
  final int index;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: title,
            style: Styles.textStyle15.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
              text: subTitle,
              style: Styles.textStyle15
          ),
        ],
      ),
    );
  }
}