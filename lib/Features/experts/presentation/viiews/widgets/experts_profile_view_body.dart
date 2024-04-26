import 'package:flutter/material.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/custom_experts_info_body.dart';

class ExpertsProfileViewBody extends StatelessWidget {
  const ExpertsProfileViewBody({
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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CustomExpertsInfoBody(
            id: id,
            ownerId: farmOwnerId,
            rateCount: rateCount,
          ),
          // ),
        ),
      ],
    );
  }
}
