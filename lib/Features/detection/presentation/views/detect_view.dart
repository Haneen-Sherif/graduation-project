import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/detect_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_app_bar.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';
import 'package:graduation_project/generated/assets.dart';

class DetectView extends StatefulWidget {
  const DetectView({super.key});

  @override
  State<DetectView> createState() => _DetectViewState();
}

class _DetectViewState extends State<DetectView> {
  GlobalKey<ScaffoldState> detectKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: detectKey,
        drawer: const CustomDrawer(),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.only(top: 16, left: 21),
            child: CustomForgotPasswordBackIcon(),
          ),
          // child: CustomAppBar(
          //   anotherKey: detectKey,
          // ),
        ),
        body: const DetectViewBody(),
      ),
    );
  }
}
