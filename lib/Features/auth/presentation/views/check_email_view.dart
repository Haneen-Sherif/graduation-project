import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/check_email_view_body.dart';

class CheckEmailView extends StatelessWidget {
  const CheckEmailView({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CheckEmailViewBody(
        email: email,
      ),
    );
  }
}
