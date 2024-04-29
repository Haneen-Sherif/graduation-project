import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomProfileTextFormField extends StatelessWidget {
  const CustomProfileTextFormField({
    super.key,
    required this.size,
    required this.keyboardType,
    required this.textInputAction,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText,
    this.onSaved,
    this.enabled,
    this.suffixIcon,
  });

  final Size size;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String hintText;
  final void Function(String?)? onSaved;
  final bool? enabled;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      onSaved: onSaved,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      controller: controller,
      cursorColor: kPrimaryColor,
      validator: validator,
      obscureText: obscureText ?? false,
      cursorHeight: 20.0,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        errorMaxLines: 2,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        hintStyle: Styles.textStyle12(context).copyWith(
            color: Color(0xff858585),
            letterSpacing: 0.90,
            fontWeight: FontWeight.w500),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE9E6E6)),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kPrimaryColor),
          borderRadius: BorderRadius.circular(5),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE9E6E6)),
          borderRadius: BorderRadius.circular(5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffE9E6E6)),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
