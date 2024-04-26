import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/detect_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class DetectView extends StatelessWidget {
  const DetectView({Key? key, required this.id}) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(child: CustomForgotPasswordBackIcon()),
          title: CustomTitle(title: "Image Upload"),
          centerTitle: true,
        ),
        body: DetectViewBody(id: id),
      ),
    );
  }
}
