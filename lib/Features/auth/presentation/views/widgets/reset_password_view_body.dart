import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/forgot_password_header.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/reset_password_form.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;

  @override
  void initState() {
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.dispose();
  }

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ForgotPasswordHeader(),
              const SizedBox(
                height: 52,
              ),
              Text(
                'Reset password',
                style: Styles.textStyle30.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.30,
                ),
              ),
              const SizedBox(
                height: 13,
              ),
              Text(
                'Please type something you’ll remember',
                style: Styles.textStyle16.copyWith(
                  color: Colors.black.withOpacity(0.699999988079071),
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              ResetPasswordForm(
                formKey: formKey,
                newPasswordController: newPasswordController,
                size: size,
                confirmNewPasswordController: confirmNewPasswordController,
              ),
              const SizedBox(
                height: 29,
              )
            ],
          ),
        ),
      ),
    );
  }
}
