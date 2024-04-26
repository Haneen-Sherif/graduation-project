import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer(),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: HomeViewBody(
            scaffoldKey: scaffoldKey,
          )),
    );
  }
}
