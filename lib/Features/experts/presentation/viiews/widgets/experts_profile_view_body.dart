import 'package:flutter/material.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/custom_experts_info_body.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';

class ExpertsProfileViewBody extends StatelessWidget {
  const ExpertsProfileViewBody({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: CustomExpertsInfoBody(
              id: id,
            ),
          ),
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              Expanded(
                child: const SizedBox(
                  height: 12,
                ),
              ),
              HomeFooterWidget(size: size)
            ],
          ),
        )
      ],
    );
  }
}
