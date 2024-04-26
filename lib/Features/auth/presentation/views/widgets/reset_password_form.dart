import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    super.key,
    required this.formKey,
    required this.newPasswordController,
    required this.size,
    required this.confirmNewPasswordController,
    required this.email,
    required this.code,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController newPasswordController;
  final Size size;
  final TextEditingController confirmNewPasswordController;
  final String email;
  final String code;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  bool newPasswordVisible = true;
  bool confirmNewPasswordVisible = true;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final bool digitRegex = true;
    final bool upperRegex = true;
    final bool nonAlphanumericRegex = true;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
        if (state is ChangedSuccess) {
          context.push(AppRoutes.kPasswordChangedView);
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoading)
              Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            Text(
              'New password',
              style: Styles.textStyle14(context).copyWith(
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomTextFormField(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    newPasswordVisible = !newPasswordVisible;
                  });
                },
                icon: newPasswordVisible
                    ? Icon(
                        Icons.visibility_outlined,
                        color: Colors.black.withOpacity(0.6),
                      )
                    : Icon(Icons.visibility_off_outlined,
                        color: Colors.black.withOpacity(0.6)),
              ),
              hintTextColor: Colors.black.withOpacity(0.5),
              borderColor: const Color(0xFFD8DADC),
              fillColor: Colors.transparent,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              obscureText: newPasswordVisible,
              text: "must be 8 characters",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your new password';
                } else if (value.length < 8) {
                  return 'Password must be at least 8 characters.';
                } else if (upperRegex != RegExp(r'.*[A-Z].*').hasMatch(value)) {
                  return "Password must have at least one uppercase ('A'-'Z').";
                } else if (digitRegex != RegExp(r'.*[0-9].*').hasMatch(value)) {
                  return "Password must have at least one digit ('0'-'9').";
                } else if (nonAlphanumericRegex !=
                    RegExp(r'.*[^a-zA-Z0-9].*').hasMatch(value)) {
                  return "Password must have at least one special character.";
                }
                return null;
              },
              controller: widget.newPasswordController,
              width: widget.size.width * 0.8,
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              'Confirm new password',
              style: Styles.textStyle14(context).copyWith(
                fontFamily: 'Inter',
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            CustomTextFormField(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    confirmNewPasswordVisible = !confirmNewPasswordVisible;
                  });
                },
                icon: confirmNewPasswordVisible
                    ? Icon(
                        Icons.visibility_outlined,
                        color: Colors.black.withOpacity(0.6),
                      )
                    : Icon(Icons.visibility_off_outlined,
                        color: Colors.black.withOpacity(0.6)),
              ),
              hintTextColor: Colors.black.withOpacity(0.5),
              borderColor: const Color(0xFFD8DADC),
              fillColor: Colors.transparent,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              obscureText: confirmNewPasswordVisible,
              text: "repeat password",
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Re-password must not be empty';
                }
                if (widget.newPasswordController.text !=
                    widget.confirmNewPasswordController.text) {
                  return "Please make sure your passwords match";
                }
                return null;
              },
              controller: widget.confirmNewPasswordController,
              width: widget.size.width * 0.8,
            ),
            const SizedBox(
              height: 61,
            ),
            Center(
              child: CustomButton(
                width: widget.size.width * 0.8,
                text: "Reset password",
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    widget.formKey.currentState!.save();
                    BlocProvider.of<AuthCubit>(context).resetPassword(
                      widget.email,
                      widget.code,
                      widget.newPasswordController.text,
                      widget.confirmNewPasswordController.text,
                    );
                  }
                },
              ),
            ),
            const SizedBox(
              height: 29,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style: Styles.textStyle14(context).copyWith(
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
                    style: Styles.textStyle14(context).copyWith(
                      color: kPrimaryColor,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
