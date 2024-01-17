import 'package:flutter/material.dart';
import 'package:graduation_project/core/utils/Widgets/custom_text_form_field.dart';

class VerifyCodeListViewItem extends StatelessWidget {
  const VerifyCodeListViewItem({
    super.key,
    required this.last,
    required this.first,
    required this.codeController,
    required this.size,
  });

  final bool last;
  final bool first;
  final TextEditingController codeController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: CustomTextFormField(
        onChanged: (value) {
          if (value.isNotEmpty && last == false) {
            FocusScope.of(context).nextFocus();
          } else if (value.isEmpty && first == false) {
            FocusScope.of(context).previousFocus();
          }
        },
        borderColor: const Color(0xFFD8DADC),
        hintTextColor: Colors.black.withOpacity(0.5),
        fillColor: Colors.transparent,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        obscureText: false,
        text: "",
        validator: (value) {
          if (value!.isEmpty) {
            return '';
          }
          return null;
        },
        controller: codeController,
        width: size.width * 1.4,
      ),
    );
  }
}
