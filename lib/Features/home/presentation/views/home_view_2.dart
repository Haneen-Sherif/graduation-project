import 'package:flutter/material.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_view_body_2.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawr_2.dart';

class HomeView2 extends StatefulWidget {
  const HomeView2({super.key});

  @override
  State<HomeView2> createState() => _HomeView2State();
}

class _HomeView2State extends State<HomeView2> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const CustomDrawer2(),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: HomeViewBody2(
          scaffoldKey: scaffoldKey,
        ),
      ),
    );
  }
}
