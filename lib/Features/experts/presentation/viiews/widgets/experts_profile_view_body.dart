import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';
import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/Features/experts/presentation/viiews/widgets/custom_experts_info_body.dart';
import 'package:graduation_project/Features/home/presentation/views/widgets/home_footer_widget.dart';

class ExpertsProfileViewBody extends StatelessWidget {
  const ExpertsProfileViewBody({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    final List<ExpertsModel> expertsList =
        BlocProvider.of<ExpertsCubit>(context).expertsList;

    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: CustomExpertsInfoBody(
              expertsList: expertsList,
              index: index,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          HomeFooterWidget(size: size)
        ],
      ),
    );
  }
}
