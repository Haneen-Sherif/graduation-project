import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forget_password.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/core/utils/routes.dart';

class CustomSignInForm extends StatelessWidget {
  const CustomSignInForm({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    return Form(
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
            emailController: emailController,
            width: width,
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
            emailController: passwordController,
            width: width,
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
            width: width,
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
