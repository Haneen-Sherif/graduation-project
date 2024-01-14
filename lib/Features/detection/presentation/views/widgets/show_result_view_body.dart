import 'package:flutter/material.dart';
import 'package:graduation_project/Features/detection/data/models/disease_result_model.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/disease_result.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class ShowResultViewBody extends StatelessWidget {
  const ShowResultViewBody({super.key});

  static const List<DiseaseResultModel> diseaseResultLest = [
    DiseaseResultModel(
      diseaseName: "Aeromoniasis",
      diseaseType: "Lorem ipsum",
      recommendationAction:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed auctor nisl sit amet nisi fermentum, at bibendum mauris pulvinar. Quisque nec nisl a elit convallis tempus. Duis facilisis, dolor id volutpat ultrices, quam justo interdum neque, vel tempus libero ligula vel libero. In hac habitasse platea dictumst. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Nunc vel nisi non mi tincidunt luctus nec nec ligula. Morbi ac efficitur justo, ut consectetur justo. Proin vel lacinia lacus.",
      diseaseImage: Assets.imagesResultImage,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Text('Result', style: Styles.textStyle27),
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: diseaseResultLest.length,
              itemBuilder: (context, index) {
                return DiseaseResult(
                  diseaseName: diseaseResultLest[index].diseaseName,
                  diseaseType: diseaseResultLest[index].diseaseType,
                  diseaseImage: diseaseResultLest[index].diseaseImage,
                  recommendationAction:
                      diseaseResultLest[index].recommendationAction,
                );
              },
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          CustomButton(
            width: size.width * 0.8,
            text: "Contact Doctor",
            onPressed: () {},
          ),
          const SizedBox(
            height: 60,
          ),
          HomeFooterWidget(size: size)
        ],
      ),
    );
  }
}
