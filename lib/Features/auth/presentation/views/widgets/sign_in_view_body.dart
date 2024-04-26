import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/another_option.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_sign_in_form.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_sign_in_text.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/generated/assets.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(Assets.imagesDecoration),
          CustomSignInText(width: width),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Column(
              children: [
                const SizedBox(
                  height: 48,
                ),
                Center(
                  child: SizedBox(
                    width: width * 0.7,
                    child: Image.asset(Assets.imagesSignIn),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                CustomSignInForm(width: width),
                const SizedBox(
                  height: 8,
                ),
                AnotherOption(
                  text1: 'Don’t have an account ?',
                  text2: ' Sign Up',
                  onTap: () {
                    context.push(AppRoutes.kSignUpView);
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}
