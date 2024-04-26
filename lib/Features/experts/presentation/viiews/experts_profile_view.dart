import 'package:flutter/material.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/experts_profile_view_body.dart';
import 'package:graduation_project/core/utils/Widgets/custom_drawer.dart';

class ExpertsProfileView extends StatefulWidget {
  const ExpertsProfileView(
      {super.key,
      required this.id,
      required this.farmOwnerId,
      required this.rateCount});

  final String id;
  final String farmOwnerId;
  final int rateCount;

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
        body: ExpertsProfileViewBody(
          id: widget.id,
          farmOwnerId: widget.farmOwnerId,
          rateCount: widget.rateCount,
        ),
      ),
    );
  }
}
