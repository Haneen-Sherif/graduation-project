import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/show_result_view_body.dart';

import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class ShowResultView extends StatelessWidget {
  const ShowResultView({
    Key? key,
    required this.name,
    required this.per,
    required this.img,
    required this.type,
    required this.action,
  }) : super(key: key);

  final String name;
  final String img;
  final String type;
  final List<dynamic> action;
  final double per;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Center(child: CustomForgotPasswordBackIcon()),
          title: CustomTitle(title: "Result"),
          centerTitle: true,
        ),
        body: ShowResultViewBody(
          name: name,
          per: per,
          img: img,
          type: type,
          action: action,
        ),
      ),
    );
  }
}
