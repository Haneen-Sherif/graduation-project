import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/styles.dart';

class DiseaseInfoOrder extends StatelessWidget {
  const DiseaseInfoOrder({
    super.key,
    required this.number,
  });

  final String number;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: Container(
        width: 24,
        height: 22,
        decoration: const ShapeDecoration(
          color: Color(0xff777BCB),
          shape: OvalBorder(
            side: BorderSide(
              width: 1,
              color: Color(0xff777BCB),
            ),
          ),
        ),
        child: Center(
          child: Text(
            number,
            style: Styles.textStyle12.copyWith(
              fontWeight: FontWeight.w700,
              fontFamily: "Montserrat",
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
