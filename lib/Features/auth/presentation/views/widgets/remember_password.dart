import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';

class RememberPassword extends StatelessWidget {
  const RememberPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Remember password? ',
          style: Styles.textStyle14.copyWith(
            color: Colors.black.withOpacity(0.699999988079071),
            fontFamily: 'Inter',
          ),
        ),
        GestureDetector(
          onTap: () {
            context.pushReplacement(AppRoutes.kSignInView);
          },
          child: Text(
            'Log in',
            style: Styles.textStyle14.copyWith(
              color: kPrimaryColor,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
