import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/profle/presentation/manager/profile_cubit/profile_cubit.dart';
import 'package:graduation_project/Features/profle/presentation/views/widgets/custom_profile_text_form_field.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ChangePasswordViewBody extends StatefulWidget {
  const ChangePasswordViewBody({super.key, required this.id});
  final String id;

  @override
  State<ChangePasswordViewBody> createState() => _ChangePasswordViewBodyState();
}

class _ChangePasswordViewBodyState extends State<ChangePasswordViewBody> {
  late TextEditingController passwordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  bool isLoading = false;

  @override
  void initState() {
    passwordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  bool buttonClicked = false;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bool digitRegex = true;
    final bool upperRegex = true;
    final bool nonAlphanumericRegex = true;
    Size size = MediaQuery.sizeOf(context);
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoading) {
          setState(() {
            isLoading = true;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
        if (state is UpdateSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: kPrimaryColor,
            ),
          );
          context.pop();
        } else if (state is ProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: Form(
        autovalidateMode:
            buttonClicked ? AutovalidateMode.always : AutovalidateMode.disabled,
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 74,
                ),
                Text(
                  "Current Password",
                  style: Styles.textStyle16(context)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 3,
                ),
                CustomProfileTextFormField(
                  obscureText: true,
                  size: size,
                  controller: passwordController,
                  hintText: "",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your current password';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "New Password",
                  style: Styles.textStyle16(context)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 3,
                ),
                CustomProfileTextFormField(
                  obscureText: true,
                  size: size,
                  controller: newPasswordController,
                  hintText: "",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password must not be empty';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters.';
                    } else if (upperRegex !=
                        RegExp(r'.*[A-Z].*').hasMatch(value)) {
                      return "Password must have at least one uppercase ('A'-'Z').";
                    } else if (digitRegex !=
                        RegExp(r'.*[0-9].*').hasMatch(value)) {
                      return "Password must have at least one digit ('0'-'9').";
                    } else if (nonAlphanumericRegex !=
                        RegExp(r'.*[^a-zA-Z0-9].*').hasMatch(value)) {
                      return "Password must have at least one special character.";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  "Confirm Passowrd",
                  style: Styles.textStyle16(context)
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 3,
                ),
                CustomProfileTextFormField(
                  size: size,
                  controller: confirmPasswordController,
                  hintText: "",
                  obscureText: true,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Confirm password must not be empty';
                    }
                    if (newPasswordController.text !=
                        confirmPasswordController.text) {
                      return "Please make sure your passwords match";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 74,
                ),
                Align(
                  alignment: Alignment.center,
                  child: CustomButton(
                    width: size.width * 0.4,
                    text: "Confirm",
                    onPressed: () {
                      setState(() {
                        buttonClicked = true;
                      });
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<ProfileCubit>(context)
                            .updateUserPassword(
                          widget.id,
                          passwordController.text,
                          newPasswordController.text,
                          confirmPasswordController.text,
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
