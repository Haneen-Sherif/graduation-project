import 'package:flutter/material.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomExpertsInfo extends StatelessWidget {
  const CustomExpertsInfo({
    super.key,
    // required this.expertsList,
    required this.id,
    required this.title,
    required this.subTitle,
  });

  // final List<ExpertsModel> expertsList;
  final String id;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: Styles.textStyle12
              .copyWith(fontWeight: FontWeight.w500, color: Color(0xff979799)),
        ),
        SizedBox(
          width: 32,
        ),
        Text(subTitle,
            style: Styles.textStyle15
                .copyWith(color: Colors.black.withOpacity(0.78))),
      ],
    );
  }
}
