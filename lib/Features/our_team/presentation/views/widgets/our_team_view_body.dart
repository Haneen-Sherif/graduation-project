import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/Features/our_team/data/models/our_team_model.dart';
import 'package:graduation_project/Features/our_team/presentation/manager/our_team_cubit/our_team_cubit.dart';
import 'package:graduation_project/Features/our_team/presentation/views/widgets/our_team_item.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';

class OurTeamViewBody extends StatelessWidget {
  const OurTeamViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OurTeamModel> ourTeamList =
        BlocProvider.of<OurTeamCubit>(context).ourTeamList;
    final Size size = MediaQuery.of(context).size;
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: CustomTitle(title: "Our Team"),
              ),
              SizedBox(
                height: 45,
              ),
            ],
          ),
        ),
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.8,
            crossAxisSpacing: 32,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: OurTeamItem(
                ourTeamList: ourTeamList,
                index: index,
              ),
            );
          },
          itemCount: ourTeamList.length,
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: [
              const Expanded(
                child: SizedBox(
                  height: 16,
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
