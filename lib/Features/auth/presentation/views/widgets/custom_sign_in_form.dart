import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
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
  bool passwordVisible = true;
  bool isLoading = false;
  late TextEditingController passwordController;

  late TextEditingController nameController;

  @override
  void initState() {
    passwordController = TextEditingController();
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
          if (state is LoginSuccess) {
            context.push(AppRoutes.kHomeView);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Column(
            children: [
              if (isLoading) CircularProgressIndicator(),
              CustomTextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                obscureText: false,
                text: "Username",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Username must not be empty';
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
                textInputAction: TextInputAction.done,
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
                height: 5,
              ),
              CustomForgetPassword(
                onTap: () {
                  context.push(AppRoutes.kForgotPasswordView);
                },
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
                    BlocProvider.of<AuthCubit>(context)
                        .signIn(nameController.text, passwordController.text);
                  }
                },
              ),
            ],
          ),
        ));
  }
}

OutlineInputBorder buildOutlineInputBorder(Color color) {
  return OutlineInputBorder(
    borderSide: BorderSide(color: color),
    borderRadius: BorderRadius.circular(12),
  );
}
