import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_sign_in_form.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.width,
    required this.validator,
    required this.text,
    required this.obscureText,
    required this.keyboardType,
    required this.textInputAction,
  });

  final TextEditingController controller;
  final double width;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String text;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: controller,
      cursorColor: kPrimaryColor,
      validator: validator,
      obscureText: obscureText,
      cursorHeight: 20.0,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: width * 0.05),
        labelText: text,
        labelStyle: Styles.textStyle15.copyWith(
          color: Colors.black.withOpacity(0.78),
          letterSpacing: 0.90,
        ),
        fillColor: Colors.white,
        filled: true,
        border: buildOutlineInputBorder(Colors.white),
        errorBorder: buildOutlineInputBorder(Colors.red),
        focusedErrorBorder: buildOutlineInputBorder(Colors.red),
        focusedBorder: buildOutlineInputBorder(kPrimaryColor),
        enabledBorder: buildOutlineInputBorder(Colors.white),
      ),
    );
  }
}
