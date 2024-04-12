import 'package:flutter/material.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CustomForgetPassword extends StatelessWidget {
  const CustomForgetPassword({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: onTap,
          child: Text(
            'Forgot Password ?',
            style: Styles.textStyle14(context).copyWith(
              color: kPrimaryColor,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.84,
            ),
          ),
        ),
      ],
    );
  }
}
