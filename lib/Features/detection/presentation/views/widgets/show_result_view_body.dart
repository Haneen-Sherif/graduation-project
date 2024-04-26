import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/detection/data/models/disease_result_model.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/disease_result.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/generated/assets.dart';

class ShowResultViewBody extends StatelessWidget {
  const ShowResultViewBody(
      {super.key,
      required this.name,
      required this.per,
      required this.img,
      required this.type,
      required this.action});

  final String name;
  final String img;
  final String type;
  final List<dynamic> action;
  final double per;

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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Column(children: [
            // const SizedBox(
            //   height: 16,
            // ),
            // Text('Result', style: Styles.textStyle27(context)),
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
                    diseaseName: name,
                    diseasePer: per,
                    diseaseType: type,
                    diseaseImage: img,
                    recommendationAction: action,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
              width: size.width * 0.4,
              text: "Chat",
              onPressed: () {
                context.push(AppRoutes.kChatView);
              },
            ),
          ]),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(children: [
            const Expanded(
              child: SizedBox(
                height: 60,
              ),
            ),
            // HomeFooterWidget(size: size)
          ]),
        )
      ],
    );
  }
}
