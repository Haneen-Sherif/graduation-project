import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/core/utils/routes.dart';

class CustomSignUpForm extends StatefulWidget {
  const CustomSignUpForm({super.key, required this.width});

  final double width;

  @override
  State<CustomSignUpForm> createState() => _CustomSignUpFormState();
}

class _CustomSignUpFormState extends State<CustomSignUpForm> {
  bool passwordVisible = true;
  bool confirmPasswordVisible = true;
  late TextEditingController passwordController;
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    passwordController = TextEditingController();
    emailController = TextEditingController();
    nameController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    confirmPasswordController.dispose();
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
            width: widget.width,
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
            width: widget.width,
          ),
          const SizedBox(
            height: 16,
          ),
          CustomTextFormField(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
              icon: passwordVisible
                  ? Icon(
                      Icons.visibility_outlined,
                      color: Colors.black.withOpacity(0.6),
                    )
                  : Icon(Icons.visibility_off_outlined,
                      color: Colors.black.withOpacity(0.6)),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            obscureText: passwordVisible,
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
            height: 16,
          ),
          CustomTextFormField(
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  confirmPasswordVisible = !confirmPasswordVisible;
                });
              },
              icon: confirmPasswordVisible
                  ? Icon(
                      Icons.visibility_outlined,
                      color: Colors.black.withOpacity(0.6),
                    )
                  : Icon(Icons.visibility_off_outlined,
                      color: Colors.black.withOpacity(0.6)),
            ),
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            obscureText: confirmPasswordVisible,
            text: "Confirm Password",
            validator: (value) {
              if (value!.isEmpty) {
                return 'Confirm password must not be empty';
              }
              if (passwordController.text != confirmPasswordController.text) {
                return "Please make sure your passwords match";
              }
              return null;
            },
            controller: confirmPasswordController,
            width: widget.width,
          ),
          const SizedBox(
            height: 5,
          ),
          const SizedBox(
            height: 17,
          ),
          CustomButton(
            width: widget.width,
            text: "Sign Up",
            onPressed: () {
              if (formKey.currentState!.validate()) {
                formKey.currentState!.save();
                context.pushReplacement(AppRoutes.kSignInView);
              }
            },
          ),
        ],
      ),
    );
  }
}
