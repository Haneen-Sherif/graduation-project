import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_sign_in_form.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.width,
    this.validator,
    required this.obscureText,
    required this.keyboardType,
    required this.textInputAction,
    this.hintText,
    this.fillColor,
    this.borderColor,
    this.hintTextColor,
    this.onChanged,
    this.suffixIcon,
    this.text,
    this.onSaved,
    this.controller,
  });

  final TextEditingController? controller;
  final double width;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String? text;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? hintText;
  final Color? fillColor;
  final Color? borderColor;
  final Color? hintTextColor;
  final void Function(String)? onChanged;
  final Widget? suffixIcon;
  final void Function(String?)? onSaved;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      controller: widget.controller,
      cursorColor: kPrimaryColor,
      validator: widget.validator,
      obscureText: widget.obscureText,
      cursorHeight: 20.0,
      onSaved: widget.onSaved,
      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon,
        errorMaxLines: 2,
        hintText: widget.hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: widget.width * 0.05),
        labelText: widget.text,
        labelStyle: Styles.textStyle15.copyWith(
          color: widget.hintTextColor ?? Colors.black.withOpacity(0.78),
          letterSpacing: 0.90,
        ),
        fillColor: widget.fillColor ?? Colors.white,
        filled: true,
        border: buildOutlineInputBorder(widget.borderColor ?? Colors.white),
        errorBorder: buildOutlineInputBorder(Colors.red),
        focusedErrorBorder: buildOutlineInputBorder(Colors.red),
        focusedBorder: buildOutlineInputBorder(kPrimaryColor),
        enabledBorder:
            buildOutlineInputBorder(widget.borderColor ?? Colors.white),
      ),
    );
  }
}
