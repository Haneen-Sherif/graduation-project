import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/reset_password_view_body.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key, required this.email, required this.code});

  final String email;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResetPasswordViewBody(
        email: email,
        code: code,
      ),
    );
  }
}
