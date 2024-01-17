import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forget_password.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/core/utils/routes.dart';

class CustomSignInForm extends StatefulWidget {
  const CustomSignInForm({super.key, required this.width});

  final double width;

  @override
  State<CustomSignInForm> createState() => _CustomSignInFormState();
}

class _CustomSignInFormState extends State<CustomSignInForm> {
  late TextEditingController passwordController;

  late TextEditingController emailController;

  @override
  void initState() {
    passwordController = TextEditingController();
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            obscureText: false,
            text: "Email",
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email address must not be empty';
              }
              return null;
            },
            controller: emailController,
            width: widget.width,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            obscureText: true,
            text: "Password",
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password must not be empty';
              }
              return null;
            },
            controller: passwordController,
            width: widget.width,
          ),
          const SizedBox(
            height: 5,
          ),
          CustomForgetPassword(
            onTap: () {},
          ),
          const SizedBox(
            height: 62,
          ),
          CustomButton(
            width: widget.width,
            text: "Sign In",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.pushReplacement(AppRoutes.kHomeView);
              }
            },
          ),
        ],
      ),
    );
  }
}

OutlineInputBorder buildOutlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: BorderRadius.circular(12),
  );
}
