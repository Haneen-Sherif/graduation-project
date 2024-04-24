import 'package:flutter/material.dart';

abstract class Styles {
  static TextStyle textStyle6(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 6),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textStyle7(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 7),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textStyle10(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 10),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textStyle11(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 11),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textStyle12(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textStyle13(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 13),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textStyle14(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textStyle15(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 15),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textStyle16(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textStyle18(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textStyle20(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textStyle24(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle textStyle25(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 25),
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle textStyle27(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 27),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textStyle30(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 30),
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle textStyle35(context) {
    return TextStyle(
      fontSize: getResponsiveFontSize(context, fontSize: 35),
      fontWeight: FontWeight.w500,
    );
  }
}

double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double respomsiveFontSize = fontSize * scaleFactor;
  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;
  return respomsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.sizeOf(context).width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}
