import 'package:flutter/material.dart';
import 'package:graduation_project/Features/disease_info/presentation/views/widgets/disease_info_title.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomFishInfoList extends StatelessWidget {
  const CustomFishInfoList({
    super.key,
    required this.title,
    required this.subTitle,
    required this.count,
  });

  final String title;
  final List<dynamic> subTitle;

  final int count;
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    count,
                    (index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 8, top: 8),
                          width: 4,
                          height: 4,
                          decoration: const ShapeDecoration(
                            color: Colors.black,
                            shape: OvalBorder(
                              side: BorderSide(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Text(
                            subTitle[index],
                            style: Styles.textStyle12(context).copyWith(
                              letterSpacing: 0.72,
                            ),
                          ),
                        ),
                      ],
                    ),
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
