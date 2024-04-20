import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/Features/experts/data/models/experts_model.dart';

import 'package:graduation_project/Features/experts/presentation/manager/experts_cubit/experts_cubit.dart';
import 'package:graduation_project/constants.dart';

import 'package:graduation_project/core/utils/routes.dart';
import 'package:graduation_project/core/utils/styles.dart';

class ExpertsListView extends StatelessWidget {
  const ExpertsListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpertsCubit, ExpertsState>(builder: (context, state) {
      if (state is ExpertsLoading) {
        return Center(
          child: CircularProgressIndicator(
            color: kPrimaryColor,
          ),
        );
      } else if (state is ExpertsSuccess) {
        List<ExpertsModel> experts =
            BlocProvider.of<ExpertsCubit>(context).experts;

        // print("=====================");
        // print(diseases);
        // print("=====================");
        return ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
                  width: 8,
                ),
            scrollDirection: Axis.horizontal,
            itemCount: experts.length,
            itemBuilder: (context, index) {
              ExpertsModel expert = experts[index];
              return GestureDetector(
                onTap: () {
                  context.push(
                    AppRoutes.kExpertsProfileView,
                    extra: expert.id,
                  );
                },
                child: SizedBox(
                  width: 74,
                  child: Container(
                    margin: EdgeInsets.zero,
                    padding:
                        const EdgeInsets.only(bottom: 2, right: 1, left: 1),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          offset: const Offset(4, 4),
                          blurRadius: 6,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Card(
                      margin: EdgeInsets.zero,
                      elevation: 0,
                      child: Column(
                        children: [
                          Image.network(
                            expert.personalPhoto ?? '',
                            height: 96,
                            width: 79,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            height: 23,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Dr. ",
                                  style: Styles.textStyle7(context).copyWith(
                                    letterSpacing: 0.96,
                                  ),
                                ),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  expert.userName ?? '',
                                  style: Styles.textStyle7(context).copyWith(
                                    letterSpacing: 0.96,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      } else if (state is ExpertsFailure) {
        return Center(
          child: Text('Failed to load experts: ${state.message}'),
        );
      } else {
        final experts = BlocProvider.of<ExpertsCubit>(context).getAllExperts();

        print("=====================");
        print(experts);
        print("=====================");
        final experts2 = BlocProvider.of<ExpertsCubit>(context).experts;

        print("=====================");
        print(experts2);
        print("=====================");
        return Container();
      }
    });
  }
}
