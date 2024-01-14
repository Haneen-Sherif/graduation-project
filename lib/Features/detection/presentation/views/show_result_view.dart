import 'package:flutter/material.dart';
import 'package:graduation_project/Features/detection/presentation/views/widgets/show_result_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_app_bar.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class ShowResultView extends StatefulWidget {
  const ShowResultView({super.key});

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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: CustomAppBar(
            anotherKey: showResultKey,
          ),
        ),
        body: const ShowResultViewBody(),
      ),
    );
  }
}
