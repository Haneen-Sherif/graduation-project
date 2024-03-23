import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/experts_profile_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_app_bar.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class ExpertsProfileView extends StatefulWidget {
  const ExpertsProfileView({super.key, required this.id});

  final String id;

  @override
  State<ExpertsProfileView> createState() => _ExpertsProfileViewState();
}

class _ExpertsProfileViewState extends State<ExpertsProfileView> {
  GlobalKey<ScaffoldState> expertsInfoKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: expertsInfoKey,
        drawer: const CustomDrawer(),
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(70),
        //   child: CustomAppBar(
        //     anotherKey: expertsInfoKey,
        //   ),
        // ),
        body: ExpertsProfileViewBody(id: widget.id),
      ),
    );
  }
}
