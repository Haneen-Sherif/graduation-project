import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class DiseaseResult extends StatelessWidget {
  const DiseaseResult({
    super.key,
    required this.diseaseName,
    required this.diseaseType,
    required this.diseaseImage,
    required this.recommendationAction,
  });

  final String diseaseName;
  final String diseaseType;
  final String diseaseImage;
  final String recommendationAction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Disease Name: ',
                          style: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.96,
                          ),
                        ),
                        TextSpan(
                          text: diseaseName,
                          style: Styles.textStyle16.copyWith(
                            letterSpacing: 0.96,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 31,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Disease Type : ',
                          style: Styles.textStyle16.copyWith(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.96,
                          ),
                        ),
                        TextSpan(
                          text: diseaseType,
                          style: Styles.textStyle16.copyWith(
                            letterSpacing: 0.96,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: Image.asset(diseaseImage))
          ],
        ),
        const SizedBox(
          height: 56,
        ),
        Text(
          'Recommendation action :',
          style: Styles.textStyle16.copyWith(
            fontWeight: FontWeight.w500,
            letterSpacing: 0.96,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            recommendationAction,
            style: Styles.textStyle13,
          ),
        )
      ],
    );
  }
}