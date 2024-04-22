import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/remember_password.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.size,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: kPrimaryColor,
              ),
            );
            context.push(AppRoutes.kCheckEmailView,
                extra: emailController.text);
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
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Email address',
                style: Styles.textStyle14(context).copyWith(
                  fontFamily: 'Inter',
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              CustomTextFormField(
                hintTextColor: Colors.black.withOpacity(0.5),
                borderColor: const Color(0xFFD8DADC),
                fillColor: Colors.transparent,
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                text: "Enter your email address",
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                controller: emailController,
                width: size.width * 0.8,
              ),
              const SizedBox(
                height: 54,
              ),
              Center(
                child: CustomButton(
                  width: size.width * 0.8,
                  text: "Send code",
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      BlocProvider.of<AuthCubit>(context).forgot(
                        emailController.text,
                      );
                      // context.push(AppRoutes.kCheckEmailView);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              const RememberPassword(),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ));
  }
}
