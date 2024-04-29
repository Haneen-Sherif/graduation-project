import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/profle/presentation/views/widgets/change_password_view_body.dart';
import 'package:graduation_project/constants.dart';
import 'package:graduation_project/core/utils/styles.dart';
import 'package:graduation_project/generated/assets.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            context.pop();
          },
          child: Image.asset(
            Assets.iconsBack,
            color: Colors.white,
          ),
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          "Change Password",
          style: Styles.textStyle18(context).copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ChangePasswordViewBody(
        id: id,
      ),
    );
  }
}
