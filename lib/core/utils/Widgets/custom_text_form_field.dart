import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_sign_in_form.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.width,
    required this.validator,
    required this.text,
    required this.obscureText,
    required this.keyboardType,
    required this.textInputAction, this.hintText,
  });

  final TextEditingController controller;
  final double width;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String text;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? hintText;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      cursorColor: kPrimaryColor,
      validator: widget.validator,
      obscureText: widget.obscureText,
      cursorHeight: 20.0,
      decoration: InputDecoration(
        errorMaxLines: 2,
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: widget.width * 0.05),
        labelText: widget.text,
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
