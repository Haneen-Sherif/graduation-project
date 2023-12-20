import 'package:flutter/material.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/widgets/disease_info_title.dart';
import 'package:graduation_project/Features/home/data/models/fish_model.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomFishInfoRow extends StatelessWidget {
  const CustomFishInfoRow({
    super.key,
    required this.title,
    required this.subTitle,
    required this.diseaseInfoList,
    required this.index,
  });

  final String title;
  final String subTitle;
  final List<FishModel> diseaseInfoList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DiseaseInfoTitle(text: title),
              const SizedBox(
                height: 4,
              ),
              Text(
                subTitle,
                style: Styles.textStyle12.copyWith(
                  letterSpacing: 0.72,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 13,
        ),
        Expanded(
          flex: 1,
          child: Image.asset(diseaseInfoList[index].image),
        )
      ],
    );
  }
}
