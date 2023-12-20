import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/core/utils/routes.dart';

class CustomSignUpForm extends StatelessWidget {
  const CustomSignUpForm({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    return Form(
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            obscureText: false,
            text: "Name",
            validator: (value) {
              if (value!.isEmpty) {
                return 'Name must not be empty';
              }
              return null;
            },
            controller: nameController,
            width: width,
          ),
          const SizedBox(
            height: 16,
          ),
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
            width: width,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            obscureText: true,
            text: "Password",
            validator: (value) {
              if (value!.isEmpty) {
                return 'Password must not be empty';
              }
              return null;
            },
            controller: passwordController,
            width: width,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            obscureText: true,
            text: "Confirm Password",
            validator: (value) {
              if (value!.isEmpty) {
                return 'Re-password must not be empty';
              }
              if (passwordController.text != confirmPasswordController.text) {
                return "Please make sure your passwords match";
              }
              return null;
            },
            controller: confirmPasswordController,
            width: width,
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 17,
          ),
          CustomButton(
            width: width,
            text: "Sign Up",
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
