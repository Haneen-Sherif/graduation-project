import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_sign_in_form.dart';
import 'package:graduation_project/core/utils/styles.dart';

class FeedbackTextFormField extends StatelessWidget {
  const FeedbackTextFormField({
    super.key,
    required this.keyboardType,
    required this.textInputAction,
    required this.controller,
    required this.validator,
    this.lebelText,
    this.minLines,
    this.maxLines,
    this.hintText,
  });

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;
  final String? Function(String? p1)? validator;
  final String? lebelText;
  final String? hintText;
  final int? minLines;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: controller,
      cursorColor: Color(0xffafb0b8),
      validator: validator,
      cursorHeight: 20.0,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.fromLTRB(10, 12, 10, 12),
        errorMaxLines: 2,
        labelText: lebelText,
        hintText: hintText,
        hintStyle: Styles.textStyle15(context).copyWith(
          color: Color(0xffafb0b8),
          letterSpacing: 0.90,
        ),
        labelStyle: Styles.textStyle15(context).copyWith(
          color: Color(0xffafb0b8),
          letterSpacing: 0.90,
        ),
        fillColor: Color(0xfff5f2f2),
        filled: true,
        border: buildOutlineInputBorder(Color(0xffafb0b8)),
        errorBorder: buildOutlineInputBorder(Colors.red),
        focusedErrorBorder: buildOutlineInputBorder(Colors.red),
        focusedBorder: buildOutlineInputBorder(Color(0xffafb0b8)),
        enabledBorder: buildOutlineInputBorder(Color(0xffafb0b8)),
      ),
    );
  }
}
