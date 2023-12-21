import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: BlocProvider.of<HomeCubit>(context).scaffoldKey,
      drawer: const CustomDrawer(),
      body: HomeViewBody(
        scaffoldKey: BlocProvider.of<HomeCubit>(context).scaffoldKey,
      ),
    );
  }
}
