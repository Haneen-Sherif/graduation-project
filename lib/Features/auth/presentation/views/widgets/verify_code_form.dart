import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/manager/auth_cubit.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/verify_code_list_view_item.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';

class VerifyCodeForm extends StatefulWidget {
  const VerifyCodeForm({
    super.key,
    required this.formKey,
    required this.size,
    required this.email,
  });

  final GlobalKey<FormState> formKey;
  final Size size;
  final String email;

  @override
  State<VerifyCodeForm> createState() => _VerifyCodeFormState();
}

class _VerifyCodeFormState extends State<VerifyCodeForm> {
  late TextEditingController c1;
  late TextEditingController c2;

  late TextEditingController c3;

  late TextEditingController c4;
  bool isLoading = false;

  @override
  void initState() {
    c1 = TextEditingController();
    c2 = TextEditingController();
    c3 = TextEditingController();
    c4 = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    c1.dispose();
    c2.dispose();
    c3.dispose();
    c4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerificationLoading) {
            setState(() {
              isLoading = true;
            });
          } else {
            setState(() {
              isLoading = false;
            });
          }
          if (state is VerificationSuccess) {
            context.push(AppRoutes.kResetPasswordView, extra: {
              'email': widget.email,
              'code': c1.text + c2.text + c3.text + c4.text
            });
          } else if (state is VerificationFailure) {
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
            children: [
              if (isLoading)
                Center(
                  child: CircularProgressIndicator(
                    color: kPrimaryColor,
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: VerifyCodeListViewItem(
                      codeController: c1,
                      first: true,
                      last: false,
                      size: widget.size,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: VerifyCodeListViewItem(
                      codeController: c2,
                      first: false,
                      last: false,
                      size: widget.size,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: VerifyCodeListViewItem(
                      codeController: c3,
                      first: false,
                      last: false,
                      size: widget.size,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: VerifyCodeListViewItem(
                      codeController: c4,
                      first: false,
                      last: true,
                      size: widget.size,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                width: widget.size.width * 0.8,
                text: "Verify",
                onPressed: () {
                  if (widget.formKey.currentState!.validate()) {
                    widget.formKey.currentState!.save();
                    BlocProvider.of<AuthCubit>(context).isCodeEnterTrue(
                      widget.email,
                      c1.text + c2.text + c3.text + c4.text,
                    );
                  }
                },
              ),
            ],
          ),
        ));
  }
}
