import 'package:flutter/material.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/detect_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_app_bar.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

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
          child: CustomAppBar(
            anotherKey: detectKey,
          ),
        ),
        body: const DetectViewBody(),
      ),
    );
  }
}
