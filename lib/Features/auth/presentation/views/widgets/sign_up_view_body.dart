import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/another_option.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_sign_up_form.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/google_or_facebook.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/social_media.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/generated/assets.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(Assets.imagesDecoration),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              children: [
                Image.asset(Assets.imagesLogo_2),
                const SizedBox(
                  height: 8,
                ),
                Image.asset(Assets.imagesLogo_1),
                const SizedBox(
                  height: 18,
                ),
                Center(
                  child: SizedBox(
                    width: width * 0.7,
                    child: Image.asset(Assets.imagesSignUp),
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                CustomSignUpForm(width: width),
                const SizedBox(
                  height: 15,
                ),
                AnotherOption(
                  text1: "Already Have an account ?",
                  text2: "  Sign In",
                  onTap: () {
                    context.push(AppRoutes.kSignInView);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 36,
          ),
        ],
      ),
    );
  }
}
