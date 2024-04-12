import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/forgot_password_form.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/forgot_password_header.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  late TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final Size size = MediaQuery.sizeOf(context);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 50,
            right: 20,
            left: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ForgotPasswordHeader(),
              const SizedBox(
                height: 52,
              ),
              Text(
                'Forgot password?',
                style: Styles.textStyle30(context).copyWith(
                  letterSpacing: -0.30,
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                'Don’t worry! It happens. Please enter the email associated with your account.',
                style: Styles.textStyle16(context).copyWith(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              ForgotPasswordForm(
                formKey: formKey,
                emailController: emailController,
                size: size,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
