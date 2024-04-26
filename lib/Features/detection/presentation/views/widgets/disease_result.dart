import 'dart:io';

import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class DiseaseResult extends StatelessWidget {
  const DiseaseResult({
    super.key,
    required this.diseaseName,
    required this.diseaseType,
    required this.diseaseImage,
    required this.recommendationAction,
    required this.diseasePer,
  });

  final String diseaseName;
  final String diseaseType;
  final String diseaseImage;
  final List<dynamic> recommendationAction;
  final double diseasePer;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
            child: Image.file(
          File(diseaseImage),
          width: 200,
        )),
        SizedBox(
          height: 37,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Disease Name: ',
                      style: Styles.textStyle16(context).copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.96,
                      ),
                    ),
                    TextSpan(
                      text: diseaseName,
                      style: Styles.textStyle16(context).copyWith(
                        letterSpacing: 0.96,
                      ),
                    ),
                    TextSpan(
                      text: " (${diseasePer.toString()}%)",
                      style: Styles.textStyle16(context).copyWith(
                        letterSpacing: 0.96,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Disease Type : ',
                      style: Styles.textStyle16(context).copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.96,
                      ),
                    ),
                    TextSpan(
                      text: diseaseType,
                      style: Styles.textStyle16(context).copyWith(
                        letterSpacing: 0.96,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        // Row(
        //   crossAxisAlignment: CrossAxisAlignment.end,
        //   children: [
        //     Expanded(
        //       flex: 2,
        //       child: Column(
        //         children: [
        //           Text.rich(
        //             TextSpan(
        //               children: [
        //                 TextSpan(
        //                   text: 'Disease Name: ',
        //                   style: Styles.textStyle16.copyWith(
        //                     fontWeight: FontWeight.w500,
        //                     letterSpacing: 0.96,
        //                   ),
        //                 ),
        //                 TextSpan(
        //                   text: diseaseName,
        //                   style: Styles.textStyle16.copyWith(
        //                     letterSpacing: 0.96,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           const SizedBox(
        //             height: 31,
        //           ),
        //           Text.rich(
        //             TextSpan(
        //               children: [
        //                 TextSpan(
        //                   text: 'Disease Type : ',
        //                   style: Styles.textStyle16.copyWith(
        //                     fontWeight: FontWeight.w500,
        //                     letterSpacing: 0.96,
        //                   ),
        //                 ),
        //                 TextSpan(
        //                   text: diseaseType,
        //                   style: Styles.textStyle16.copyWith(
        //                     letterSpacing: 0.96,
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Expanded(child: Image.asset(diseaseImage))
        //   ],
        // ),
        const SizedBox(
          height: 56,
        ),
        Text(
          'Recommendation action :',
          style: Styles.textStyle16(context).copyWith(
            fontWeight: FontWeight.w500,
            letterSpacing: 0.96,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recommendationAction.map((action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    action,
                    style: Styles.textStyle13(context),
                  ),
                );
              }).toList(),
            ))
      ],
    );
  }
}
