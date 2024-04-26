import 'package:flutter/material.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/experts_profile_view_body.dart';

class ExpertsProfileView extends StatelessWidget {
  const ExpertsProfileView({
    Key? key,
    required this.id,
    required this.farmOwnerId,
    required this.rateCount,
  }) : super(key: key);

  final String id;
  final String farmOwnerId;
  final int rateCount;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ExpertsProfileViewBody(
          id: id,
          farmOwnerId: farmOwnerId,
          rateCount: rateCount,
        ),
      ),
    );
  }
}
