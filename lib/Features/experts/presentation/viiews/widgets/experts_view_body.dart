import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/experts_grid_view_item.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';
import 'package:graduation_project/core/utils/Widgets/custom_title.dart';
import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/generated/assets.dart';

class ExpertsViewBody extends StatelessWidget {
  const ExpertsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final List<ExpertsModel> expertsList =
        BlocProvider.of<ExpertsCubit>(context).expertsList;
    return SingleChildScrollView(
      child: Column(
        children: [
          const CustomTitle(title: "Experts Contacts"),
          const SizedBox(
            height: 60,
          ),
          GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: expertsList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.9,
              crossAxisSpacing: 44,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                child: GestureDetector(
                  onTap: () {
                    context.push(AppRoutes.kExpertsProfileView, extra: index);
                  },
                  child: ExpertsGridViewItem(
                    expertsList: expertsList,
                    index: index,
                  ),
                ),
              );
            },
          ),
          HomeFooterWidget(size: size)
        ],
      ),
    );
  }
}
