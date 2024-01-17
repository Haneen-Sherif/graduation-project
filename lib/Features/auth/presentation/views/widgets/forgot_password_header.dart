import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/generated/assets.dart';

class ForgotPasswordHeader extends StatelessWidget {
  const ForgotPasswordHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CustomForgotPasswordBackIcon(),
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Image.asset(
            Assets.iconsStar,
            width: 39,
          ),
        )
      ],
    );
  }
}
