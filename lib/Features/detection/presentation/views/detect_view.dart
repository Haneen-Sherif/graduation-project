import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/detect_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class DetectView extends StatefulWidget {
  const DetectView({super.key, required this.id});

  final String id;

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
        appBar: AppBar(
          leading: Center(child: CustomForgotPasswordBackIcon()),
          title: CustomTitle(title: "Image Upload"),
          centerTitle: true,
        ),
        body: DetectViewBody(id: widget.id),
      ),
    );
  }
}
