import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class DiseaseInfoOrder extends StatelessWidget {
  const DiseaseInfoOrder({
    super.key,
    required this.number,
  });

  final String number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: kPrimaryColor,
        ),
      ),
      child: Text(
        textAlign: TextAlign.center,
        number,
        style: Styles.textStyle12(context).copyWith(
          fontWeight: FontWeight.w700,
          fontFamily: "Montserrat",
          color: Colors.white,
        ),
      ),
    );
  }
}
