import 'package:flutter/material.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/widgets/disease_info_title.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomFishInfoRow extends StatelessWidget {
  const CustomFishInfoRow({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DiseaseInfoTitle(text: title),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  subTitle,
                  style: Styles.textStyle12(context).copyWith(
                    letterSpacing: 0.72,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
