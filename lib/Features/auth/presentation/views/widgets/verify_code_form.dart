import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/verify_code_list_view_item.dart';
import 'package:graduation_project/core/utils/Widgets/custom_button.dart';
import 'package:graduation_project/core/utils/routes.dart';

class VerifyCodeForm extends StatefulWidget {
  const VerifyCodeForm({
    super.key,
    required this.formKey,
    required this.size,
  });

  final GlobalKey<FormState> formKey;
  final Size size;

  @override
  State<VerifyCodeForm> createState() => _VerifyCodeFormState();
}

class _VerifyCodeFormState extends State<VerifyCodeForm> {
  late TextEditingController c1;
  late TextEditingController c2;

  late TextEditingController c3;

  late TextEditingController c4;

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
    return Form(
      autovalidateMode: AutovalidateMode.always,
      key: widget.formKey,
      child: Column(
        children: [
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
                context.push(AppRoutes.kResetPasswordView);
              }
            },
          ),
        ],
      ),
    );
  }
}
