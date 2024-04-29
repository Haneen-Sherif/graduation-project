import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_sign_in_form.dart';
import 'package:graduation_project/core/utils/styles.dart';

class FeedbackTextFormField extends StatelessWidget {
  const FeedbackTextFormField({
    super.key,
    required this.keyboardType,
    required this.textInputAction,
    required this.controller,
    this.validator,
    this.lebelText,
    this.minLines,
    this.maxLines,
    this.hintText,
    this.borderColor,
    this.fillColor,
    this.borderFocusColor,
    this.cursorColor,
    this.hintStyle,
    this.radius,
  });

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String? p1)? validator;
  final String? lebelText;
  final String? hintText;
  final int? minLines;
  final int? maxLines;
  final Color? borderColor;
  final Color? borderFocusColor;
  final Color? fillColor;
  final Color? cursorColor;
  final TextStyle? hintStyle;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: controller,
      cursorColor: cursorColor ?? Color(0xffafb0b8),
      validator: validator,
      cursorHeight: 20.0,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
        errorMaxLines: 2,
        labelText: lebelText,
        hintText: hintText,
        hintStyle: hintStyle ??
            Styles.textStyle15(context).copyWith(
              color: Color(0xffafb0b8),
              letterSpacing: 0.90,
            ),
        labelStyle: Styles.textStyle15(context).copyWith(
          color: Color(0xffafb0b8),
          letterSpacing: 0.90,
        ),
        fillColor: fillColor ?? Color(0xfff5f2f2),
        filled: true,
        border: buildOutlineInputBorder(borderColor ?? Color(0xffafb0b8),
            radius: radius),
        errorBorder: buildOutlineInputBorder(Colors.red, radius: radius),
        focusedErrorBorder: buildOutlineInputBorder(Colors.red, radius: radius),
        focusedBorder: buildOutlineInputBorder(
            borderFocusColor ?? Color(0xffafb0b8),
            radius: radius),
        enabledBorder: buildOutlineInputBorder(borderColor ?? Color(0xffafb0b8),
            radius: radius),
      ),
    );
  }
}
