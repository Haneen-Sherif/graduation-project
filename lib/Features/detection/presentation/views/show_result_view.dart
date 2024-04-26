import 'package:flutter/material.dart';
import 'package:graduation_project/Features/auth/presentation/views/widgets/custom_forgot_password_back_icon.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/show_result_view_body.dart';

import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class ShowResultView extends StatefulWidget {
  const ShowResultView({
    super.key,
    required this.name,
    required this.per,
    required this.img,
    required this.type,
    required this.action,
  });

  final String name;
  final String img;
  final String type;
  final List<dynamic> action;
  final double per;

  @override
  State<ShowResultView> createState() => _ShowResultViewState();
}

class _ShowResultViewState extends State<ShowResultView> {
  GlobalKey<ScaffoldState> showResultKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: showResultKey,
        drawer: const CustomDrawer(),
        appBar: AppBar(
          leading: Center(child: CustomForgotPasswordBackIcon()),
          title: CustomTitle(title: "Result"),
          centerTitle: true,
        ),
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(70),
        //   child: CustomAppBar(
        //     anotherKey: showResultKey,
        //   ),
        // ),
        body: ShowResultViewBody(
            name: widget.name,
            per: widget.per,
            img: widget.img,
            type: widget.type,
            action: widget.action),
      ),
    );
  }
}
