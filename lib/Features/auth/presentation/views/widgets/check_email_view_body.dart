import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_text_check_email.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/forgot_password_header.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/resend_code.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/verify_code_form.dart';
import 'package:graduation_project/core/utils/styles.dart';

class CheckEmailViewBody extends StatelessWidget {
  const CheckEmailViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
            right: 20,
            left: 20,
          ),
          child: Column(
            children: [
              const ForgotPasswordHeader(),
              const SizedBox(
                height: 52,
              ),
              Text(
                'Please check your email',
                style: Styles.textStyle30.copyWith(
                  letterSpacing: -0.30,
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              const CustomTextCheckEmail(),
              const SizedBox(
                height: 28,
              ),
              VerifyCodeForm(
                formKey: formKey,
                size: size,
              ),
              const SizedBox(
                height: 37,
              ),
              const ReSendCode(),
              const SizedBox(
                height: 37,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
