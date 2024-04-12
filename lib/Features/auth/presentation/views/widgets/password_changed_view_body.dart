import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class PasswordChangedViewBody extends StatelessWidget {
  const PasswordChangedViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Assets.iconsGroupStar),
            const SizedBox(
              height: 36,
            ),
            FittedBox(
              child: Text(
                'Password changed',
                style: Styles.textStyle30(context).copyWith(
                  letterSpacing: -0.30,
                ),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Your password has been changed succesfully',
                textAlign: TextAlign.center,
                style: Styles.textStyle16(context).copyWith(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontFamily: 'Inter',
                ),
              ),
            ),
            const SizedBox(
              height: 68,
            ),
            CustomButton(
              width: size.width * 0.8,
              text: "Back to login",
              onPressed: () {
                context.push(AppRoutes.kSignInView);
              },
            )
          ],
        ),
      ),
    );
  }
}
